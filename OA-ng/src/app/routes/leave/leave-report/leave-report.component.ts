import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService } from 'ng-zorro-antd';
import { _HttpClient, SettingsService } from '@delon/theme';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { BitService } from '@shared/Bit.service';
import { pluck } from 'rxjs/operators';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { LeaveService } from '../leave.service';

@Component({
  selector: 'leave-report',
  templateUrl: './leave-report.component.html',
  styleUrls: ['./leave-report.component.less'],
})
export class LeaveReportComponent implements OnInit {
  constructor(
    private fb: FormBuilder,
    public msg: NzMessageService,
    private bitService: BitService,
    private settingService: SettingsService,
    private leaveService: LeaveService,
    private router: Router,
  ) {}
  leaveForm: FormGroup;
  submitting = false;
  leaveTypeList: SelectOption[] = [];
  ngOnInit(): void {
    this.getLeaveType();
    this.leaveForm = this.fb.group({
      title: [null, [Validators.required]],
      date: [null, [Validators.required]],
      leaveType: [null, [Validators.required]],
      reason: [null, [Validators.required]],
    });
  }

  /**
   * 获取请假类别
   */
  getLeaveType() {
    this.bitService
      .getDictionary('LeaveType', 'all')
      .pipe(pluck('data'))
      .toPromise()
      .then((res: DictionaryItem[]) => (this.leaveTypeList = res.map(item => new SelectOption(item.code, item.name))));
  }

  submit(formvalue: any) {
    // console.log(leaveInfo);
    const leaveInfo: LeaveInfo = new LeaveInfo();
    leaveInfo.id = this.bitService.uuid();
    leaveInfo.orderNo = 'QJ' + new Date().getTime();
    leaveInfo.reason = formvalue.reason;
    leaveInfo.title = formvalue.title;
    leaveInfo.userId = this.settingService.user.id;
    leaveInfo.beginTime = formvalue.date[0].getTime();
    leaveInfo.endTime = formvalue.date[1].getTime();
    leaveInfo.leaveType = formvalue.leaveType;
    this.submitting = true;
    this.leaveService
      .insertLeave(leaveInfo)
      .toPromise()
      .then(res => {
        if (res.hasErrors) {
          this.msg.error(res.errorMessage);
          return;
        }
        this.msg.success('上报请假成功！');
        this.router.navigateByUrl('leave/leave-detail');
        this.leaveForm.reset();
      })
      .finally(() => {
        this.submitting = false;
      });
  }
}
