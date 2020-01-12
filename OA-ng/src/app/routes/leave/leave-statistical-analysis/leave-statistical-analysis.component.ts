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
import { startOfDay, endOfDay, differenceInDays, setMilliseconds } from 'date-fns';
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
  dateType: string = 'month';
  leaveType: string;
  leaveTypeList: SelectOption[] = [];
  leaveStatusList: SelectOption[] = [];
  leaveList: LeaveInfo[] = [];
  leaveSourceList: LeaveInfo[] = [];
  isLoading: boolean = false;
  isEchartLoading: boolean = false;
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
  userLeaveCountOption;

  yearLeaveOption = {
    /*    title: {
      text: '请假类型占比',
      left: 'center',
    }  */
    /*     top: 30, */

    tooltip: {
      trigger: 'item',
      formatter: '{b} : {c} ({d}%)',
    },
    visualMap: {
      show: false,
      min: 80,
      max: 600,
      inRange: {
        colorLightness: [0, 1],
      },
    },
    series: [
      {
        /*   name: '访问来源', */
        type: 'pie',
        radius: '70%',
        center: ['50%', '50%'],
        data: [
          { value: 335, name: '直接访问' },
          { value: 310, name: '邮件营销' },
          { value: 274, name: '联盟广告' },
          { value: 235, name: '视频广告' },
          { value: 400, name: '搜索引擎' },
        ].sort(function(a, b) {
          return a.value - b.value;
        }),
        roseType: 'radius',
        labelLine: {
          smooth: 0.2,
          length: 5,
          length2: 5,
        },
        itemStyle: {
          shadowBlur: 100,
          shadowColor: 'rgba(0, 0, 0, 0.5)',
        } /*         color: '#c23531', */,

        animationType: 'scale',
        animationEasing: 'elasticOut',
        animationDelay: function(idx) {
          return Math.random() * 200;
        },
      },
    ],
  };

  initEchart() {}

  /**
   *员工请假天数统计
   * @author ludaxian
   * @date 2020-01-10
   */
  getUserLeaveCountEchartData() {
    this.isEchartLoading = true;
    this.leaveService
      .getUserLeaveCountEchartData(this.dateType)
      .toPromise()
      .then(res => {
        this.userLeaveCountOption = {
          xAxis: {
            type: 'category',
          },
          tooltip: {
            trigger: 'item',
            formatter: data => {
              return `实际已请假天数:<br />${data['name']} : ${data['value']['yData']}天`;
            },
          },
          yAxis: {
            type: 'value',
          },
          dataset: {
            dimensions: ['xData', 'yData'],
            source: res['data'],
          },
          series: [
            {
              type: 'bar',
              itemStyle: {
                normal: {
                  //这里是重点
                  color: function(params) {
                    //注意，如果颜色太少的话，后面颜色不会自动循环，最好多定义几个颜色
                    var colorList = ['#e58dc2', '#fbe289', '#fbb8a1', '#90e5e7', '#6fbae1', '#c23531', '#2f4554'];
                    return colorList[params.dataIndex];
                  },
                },
              },
            },
          ],
        };
        console.log(this.userLeaveCountOption.dataset);
      })
      .finally(() => {
        this.isEchartLoading = false;
      });
  }

  ngOnInit(): void {
    this.getLeaveList();
    this.initSelect();
    this.getUserLeaveCountEchartData();
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
            if (
              setMilliseconds(endOfDay(this.dateRange[1]), 0).getTime() < Number(item['beginTime']) ||
              startOfDay(this.dateRange[0]).getTime() > Number(item['endTime'])
            ) {
              return false;
            }
            return true;
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
            this.calculationDay['successDay'] + differenceInDays(new Date(item.endTime), new Date(item.beginTime)) + 1;
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
        this.leaveSourceList = JSON.parse(JSON.stringify(this.leaveList));
        this.changeSearchType('type');
        this.calculation();
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
}
