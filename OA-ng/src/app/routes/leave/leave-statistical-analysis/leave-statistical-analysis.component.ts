import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { BitService } from '@shared/service/Bit.service';
import { pluck } from 'rxjs/operators';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { startOfDay, endOfDay, differenceInDays } from 'date-fns';
import { LeaveDetailComponent } from '@shared/component/leave-detail/leave-detail.component';
import { LeaveService } from '@shared/service/leave.service';
import { forkJoin } from 'rxjs';

@Component({
  selector: 'leave-statistical-analysis',
  templateUrl: './leave-statistical-analysis.component.html',
  styleUrls: ['./leave-statistical-analysis.component.less'],
})
export class LeaveStatisticalAnalysisComponent implements OnInit {
  constructor(
    fb: FormBuilder,
    private router: Router,
    public http: _HttpClient,
    public msg: NzMessageService,
    private bitService: BitService,
    private modalService: NzModalService,
    private leaveService: LeaveService,
  ) {}
  leaveType: string;
  leaveTypeList: SelectOption[] = [];
  leaveStatusList: SelectOption[] = [];
  leaveList: LeaveInfo[] = [];
  leaveSourceList: LeaveInfo[] = [];
  isLoading: boolean = false;
  userName: string;
  /*   faultStatus: string; */
  status: number = null;
  dateFormat = 'YYYY/MM/DD'; //时间格式转换 yyyy/MM/dd'
  dateRange = []; //时间范围startOfDay(new Date()), endOfDay(new Date())
  calculationDay = {
    successDay: 0,
    errorDay: 0,
    allDay: 0,
  };
  ngOnInit(): void {
    this.getLeaveList();
    this.initSelect();
  }

  /**
   *前台筛选
   * @author ludaxian
   * @date 2020-01-09
   * @param {string} type
   * @param {*} [data]
   */
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
            return item['status'] === Number(this.status);
          })
          .filter(item => {
            if (this.leaveType == '' || this.leaveType == null) {
              return true;
            }
            return item['leaveType'] === this.leaveType;
          })
          .filter(item => {
            if (this.dateRange.length == 0 || this.dateRange == null) {
              return true;
            }
            return (
              startOfDay(this.dateRange[0]).getTime() < Number(item['createTime']) &&
              endOfDay(this.dateRange[1]).getTime() >= Number(item['createTime'])
            );
          });
        break;
      case '':
        break;
    }
    this.calculation();
  }

  /**
   *计算请假天数
   * @author ludaxian
   * @date 2020-01-09
   */
  calculation() {
    this.calculationDay = {
      successDay: 0,
      errorDay: 0,
      allDay: 0,
    };
    let successList: LeaveInfo[] = [];
    let errList: LeaveInfo[] = [];
    this.leaveList.forEach(item => {
      if (item.status == BitService.ConstUtil.LEAVEREFUSESTATUS) {
        errList = [...errList, item];
      } else if (item.status == BitService.ConstUtil.LEAVEAGREESTATUS) {
        successList = [...successList, item];
      }
      if (item.dateType == 'ALL') {
        if (differenceInDays(new Date(item.endTime), new Date(item.beginTime)) === 0) {
          //同一天
          this.calculationDay['allDay'] = this.calculationDay['allDay'] + 1;
        } else {
          this.calculationDay['allDay'] =
            this.calculationDay['allDay'] + differenceInDays(new Date(item.endTime), new Date(item.beginTime)) + 1;
        }
      } else if (['PM', 'AM'].includes(item.dateType)) {
        this.calculationDay['allDay'] = this.calculationDay['allDay'] + 0.5;
      }
    });

    successList.forEach(item => {
      if (item.dateType == 'ALL') {
        if (differenceInDays(new Date(item.endTime), new Date(item.beginTime)) === 0) {
          //同一天
          this.calculationDay['successDay'] = this.calculationDay['successDay'] + 1;
        } else {
          this.calculationDay['successDay'] =
            this.calculationDay['allsuccessDayDay'] +
            differenceInDays(new Date(item.endTime), new Date(item.beginTime)) +
            1;
        }
      } else if (['PM', 'AM'].includes(item.dateType)) {
        this.calculationDay['successDay'] = this.calculationDay['successDay'] + 0.5;
      }
    });
    errList.forEach(item => {
      if (item.dateType == 'ALL') {
        if (differenceInDays(new Date(item.endTime), new Date(item.beginTime)) === 0) {
          //同一天
          this.calculationDay['errorDay'] = this.calculationDay['errorDay'] + 1;
        } else {
          this.calculationDay['errorDay'] =
            this.calculationDay['errorDay'] + differenceInDays(new Date(item.endTime), new Date(item.beginTime)) + 1;
        }
      } else if (['PM', 'AM'].includes(item.dateType)) {
        this.calculationDay['errorDay'] = this.calculationDay['errorDay'] + 0.5;
      }
    });
  }

  /**
   *获取请假列表
   * @author ludaxian
   * @date 2020-01-09
   */
  getLeaveList() {
    this.isLoading = true;
    this.leaveService
      .getLeaveDetailByUserId()
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.leaveList = res;
        this.calculation();
        this.leaveSourceList = JSON.parse(JSON.stringify(this.leaveList));
      })
      .finally(() => {
        this.isLoading = false;
      });
  }

  /**
   * 获取请假类型
   */
  initSelect() {
    forkJoin([
      this.bitService.getDictionary('LeaveType', 'all').pipe(pluck('data')),
      this.bitService.getDictionary('LeaveStatus', 'all').pipe(pluck('data')),
    ])
      .toPromise()
      .then((res: any) => {
        this.leaveTypeList = res[0].map(item => new SelectOption(item.code, item.name));
        this.leaveStatusList = res[1].map(item => new SelectOption(item.data, item.name));
      });
  }

  /**
   *查看详情
   *
   * @author ludaxian
   * @date 2020-01-09
   * @param Leave
   */
  detail(Leave: LeaveInfo) {
    this.modalService.create({
      nzTitle: '查看详情',
      nzContent: LeaveDetailComponent,
      nzFooter: null,
      nzWidth: 600,
      nzComponentParams: {
        leave: Leave,
      },
    });
  }
  option = {
    title: {
      text: '本月请假情况',
      /*  subtext: 'Feature Sample: Gradient Color, Shadow, Click Zoom', */
    },
    xAxis: {
      type: 'category',
      data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    },
    yAxis: {
      type: 'value',
    },
    series: [
      {
        data: [120, 200, 150, 80, 70, 110, 130],
        type: 'bar',
      },
    ],
  };
}
