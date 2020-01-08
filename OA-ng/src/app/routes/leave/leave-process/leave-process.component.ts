import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, isTemplateRef } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { LeaveService } from '../../../shared/service/leave.service';
import { pluck } from 'rxjs/operators';
import { BitService } from '@shared/service/Bit.service';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { differenceInDays, startOfDay, endOfDay } from 'date-fns';

@Component({
  selector: 'leave-process',
  templateUrl: './leave-process.component.html',
  styleUrls: ['./leave-process.component.less'],
})
export class LeaveProcessComponent implements OnInit {
  constructor(
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef,
    private router: Router,
    public http: _HttpClient,
    public msg: NzMessageService,
    private leaveService: LeaveService,
    private bitService: BitService,
  ) {}
  leaveForm: FormGroup;
  submitting = false;
  leaveList: LeaveInfo[] = [];
  leaveSourceList: LeaveInfo[] = [];
  isLoading: boolean = true;
  leaveType: string;
  leaveTypeList: SelectOption[] = [];
  userName: string;
  status: number = null; //默认审核中
  dateFormat = 'YYYY/MM/DD'; //时间格式转换 yyyy/MM/dd'
  dateRange = [startOfDay(new Date()), endOfDay(new Date())]; //时间范围
  changeSearchType(type: string, data?: any) {
    switch (type) {
      case 'type':
        this.leaveList = this.leaveSourceList
          .slice()
          .filter(item => {
            if (this.userName == '' || this.userName == null) {
              return true;
            }
            return item['userName'].includes(this.userName);
          })
          .filter(item => {
            if (this.status == null) {
              return true;
            }
            return item['status'] === this.status;
          })
          .filter(item => {
            if (this.leaveType == '' || this.leaveType == null) {
              return true;
            }
            return item['leaveType'] === this.leaveType;
          });
        /*           .filter(item => {
            if (this.dateRange == [] || this.dateRange == null) {
              return true;
            }
            return (
              startOfDay(this.dateRange[0]).getTime() < Number(item['createTime']) &&
              endOfDay(this.dateRange[1]).getTime() >= Number(item['createTime'])
            );
          }); */
        /*  .filter(item => {
            if (this.faultStatus == 'all') { 
              return true;
            }
            if (this.faultStatus == '0') {
              return ['01', '02'].includes(item['status']);
            } else if (this.faultStatus == '1') {
              return item['status'] == '03';
            }
          }); */
        break;
      case '':
        break;
    }
  }

  /**
   * 获取请假类型
   */
  getLeaveType() {
    this.bitService
      .getDictionary('LeaveType', 'all')
      .pipe(pluck('data'))
      .toPromise()
      .then((res: DictionaryItem[]) => {
        this.leaveTypeList = res.map(item => new SelectOption(item.code, item.name));
      });
  }

  /**
   * 获取请假列表
   */
  getLeaveList() {
    this.isLoading = true;
    this.leaveService
      .getAuditLeave()
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.leaveList = res;
        this.leaveSourceList = JSON.parse(JSON.stringify(this.leaveList));
        this.changeSearchType('type');
        /*   this.leave = this.leaveList[0];
        this.createLeaveProcess(this.leave.leaveProcess); */
      })
      .finally(() => {
        this.isLoading = false;
      });
  }

  /**
   * 审核请假
   * @param data
   * @param type
   */
  audit(data: LeaveInfo, type: boolean) {
    const currentAudit = data['leaveProcess'][data['leaveProcess'].length - 1];
    currentAudit['status'] = type ? 1 : 2;
    this.leaveService
      .auditLeave([currentAudit])
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          this.msg.warning(res['errorMessage']);
        } else {
          this.getLeaveList();
          this.msg.success(type ? '您已同意该申请！' : '您已拒绝该申请！');
        }
      });
  }
  /**
   * 设置不可选时间
   */
  setDisabledDateRange = (current: Date) => {
    return differenceInDays(current, startOfDay(new Date())) > 0;
  };
  ngOnInit(): void {
    this.getLeaveList();
    this.getLeaveType();
    /*  this.leaveForm = this.fb.group({
      title: [null, [Validators.required]],
      date: [null, [Validators.required]],
      leaveType: [null, [Validators.required]],
      reason: [null, [Validators.required]],
    }); */
  }

  submit() {
    this.submitting = true;
    setTimeout(() => {
      this.submitting = false;
      this.msg.success(`提交成功`);
      this.cdr.detectChanges();
    }, 1000);
  }
}
