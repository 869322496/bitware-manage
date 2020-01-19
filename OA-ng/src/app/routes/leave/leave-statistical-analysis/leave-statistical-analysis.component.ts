import { UserInfo } from '@shared/entity/UserInfo.entity';
import { SysService } from '@shared/service/sys.service';
import { Component, OnDestroy, OnInit, TemplateRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { BitService } from '@shared/service/Bit.service';
import { pluck } from 'rxjs/operators';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { startOfDay, endOfDay, differenceInDays, setMilliseconds, format } from 'date-fns';
import { LeaveDetailComponent } from '@shared/component/leave-detail/leave-detail.component';
import { LeaveService } from '@shared/service/leave.service';
import { forkJoin } from 'rxjs';
import { XlsxService } from '@delon/abc';

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
    private sysService: SysService,
    private xlsx: XlsxService,
  ) {}

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
  /* 这里是年假统计 */
  userId: string = 'all';
  userList: SelectOption[] = [];
  userLeaveCountOption;
  annualLeaveDetailList = [];
  /* 这里是请假天数统计 */
  isDataExsit: boolean = false;
  dateType: string = 'month';
  /* 这里是导出配置项参数 */
  allChecked = true;
  indeterminate = false;
  checkOptionsOne = [
    { label: '请假编号', value: 'orderNo', checked: true },
    { label: '姓名', value: 'userName', checked: true },
    { label: '请假类型', value: 'leaveTypeName', checked: true },
    { label: '请假标题', value: 'title', checked: true },
    { label: '请假时间', value: 'leaveTime', checked: true },
    { label: '请假天数', value: 'leaveDay', checked: true },
    { label: '审核状态', value: 'statusName', checked: true },
    { label: '年假共计', value: 'annualLeaveSum', checked: true },
    { label: '年假剩余', value: 'restannualLeave', checked: true },
    { label: '请假理由', value: 'reason', checked: true },
  ];
  /* [
            '请假编号',
            '姓名',
            '请假类型',
            '请假标题',
            '请假时间',
            '请假天数',
            '审核状态',
            '年假共计',
            '年假剩余',
            '请假理由',
          ], */
  ngOnInit(): void {
    this.getAnnualLeave();
    this.getLeaveList();
    this.initSelect();
    this.getUserLeaveCountEchartData();
    this.getUserList();
  }
  /**
   *
   * 获取用户列表
   * @author ludaxian
   * @date 2020-01-08
   */
  getUserList() {
    this.isLoading = true;
    this.sysService
      .getUserList()
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.userList = res.map(item => {
          return { label: item.name, value: item.id };
        });
        this.userId = this.userList[0]['value'];
      })
      .finally(() => {
        this.isLoading = false;
      });
  }
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
        if (res['data'].length == 0 || res['hasErrors']) {
          this.isDataExsit = false;
          return;
        }
        this.isDataExsit = true;
        this.userLeaveCountOption = {
          xAxis: {
            type: 'category',
          },
          tooltip: {
            trigger: 'axis',
            /*   axisPointer: {
              type: 'cross',
              crossStyle: {
                color: '#999',
              },
            }, */
            formatter: data => {
              return `实际已请假天数:<br />${data[0]['name']} : ${data[0]['value']['yData']}天`;
            },
          },
          yAxis: {
            minInterval: 0.5,
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
                    var colorList = ['#e58dc2', '#fbe289', '#90e5e7', '#fbb8a1', '#6fbae1', '#c23531', '#2f4554'];
                    return colorList[params.dataIndex];
                  },
                },
              },
            },
          ],
        };
      })
      .finally(() => {
        this.isEchartLoading = false;
      });
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
   *导出excel
   *
   * @author ludaxian
   * @date 2020-01-16
   */
  exportExcel(exportTpl: TemplateRef<any>) {
    this.modalService.create({
      nzTitle: '导出配置项',
      nzContent: exportTpl,
      nzOnCancel: () => {
        return;
      },
      nzOnOk: () => {
        if (!this.indeterminate || !this.allChecked) {
          this.msg.info('请至少选中一个配置项！');
          return false;
        }
        let excelData: any[] = [this.checkOptionsOne.filter(item => item.checked).map(item => item['label'])];
        let codeList = this.checkOptionsOne.filter(item => item.checked).map(item => item['value']);
        this.leaveList.forEach(item => {
          const annualLeaveDetail = this.annualLeaveDetailList.find(detail => detail['userId'] == item.userId);
          const getLeaveDay = data => {
            if (data.dateType == 'ALL') {
              if (differenceInDays(new Date(data.endTime), new Date(data.beginTime)) === 0) {
                //同一天
                return 1;
              } else {
                return differenceInDays(new Date(data.endTime), new Date(data.beginTime)) + 1;
              }
            } else if (['PM', 'AM'].includes(data.dateType)) {
              return 0.5;
            }
          };

          const getLeaveTime = data1 => {
            if (data1.dateType === 'ALL') {
              return `${format(item.beginTime, 'YYYY-MM-DD')} 到 ${format(item.endTime, 'YYYY-MM-DD')}`;
            } else {
              return `${format(item.beginTime, 'YYYY-MM-DD')} ${item.dateType == 'AM' ? '上午' : '下午'}`;
            }
          };

          let dataSource = [
            { code: 'orderNo', value: item.orderNo },
            { code: 'userName', value: item.userName },
            { code: 'leaveTypeName', value: item.leaveTypeName },
            { code: 'title', value: item.title },
            { code: 'leaveTime', value: getLeaveTime(item) },
            { code: 'leaveDay', value: getLeaveDay(item) },
            { code: 'statusName', value: item.statusName },
            { code: 'annualLeaveSum', value: annualLeaveDetail['annualLeaveSum'] },
            {
              code: 'restannualLeave',
              value:
                Number(annualLeaveDetail['annualLeaveSum']) - Number(annualLeaveDetail['finishLeaveSum']) > 0
                  ? Number(annualLeaveDetail['annualLeaveSum']) - Number(annualLeaveDetail['finishLeaveSum'])
                  : 0,
            },
            { code: 'reason', value: item.reason },
          ];
          let data = dataSource.filter(item => codeList.includes(item.code)).map(item1 => item1['value']);
          excelData = [...excelData, data];
        });

        this.xlsx.export({
          sheets: [
            {
              data: excelData,
              name: '请假报表',
            },
          ],
        });
      },
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
   *
   *  获取年假情况
   * @author ludaxian
   * @date 2020-01-16
   */
  getAnnualLeave() {
    this.leaveService
      .getAnnualLeave(this.userId)
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          return;
        }
        this.annualLeaveDetailList = res;
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

  yearLeaveOption = {
    /*    title: {
      text: '请假类型占比',
      left: 'center',
    }  */
    /*     top: 30, */

    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        crossStyle: {
          color: '#999',
        },
      },
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
        name: '访问来源',
        type: 'pie',
        radius: '70%',
        center: ['50%', '50%'],
        data: [
          { value: 335, name: '事假' },
          { value: 310, name: '婚假' },
          { value: 274, name: '病假' },
          { value: 235, name: '产假' },
          { value: 400, name: '年休假' },
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

  /* 复选框全选逻辑 */
  updateAllChecked(): void {
    this.indeterminate = false;
    if (this.allChecked) {
      this.checkOptionsOne = this.checkOptionsOne.map(item => {
        return {
          ...item,
          checked: true,
        };
      });
    } else {
      this.checkOptionsOne = this.checkOptionsOne.map(item => {
        return {
          ...item,
          checked: false,
        };
      });
    }
  }
  /* 复选框全选逻辑 */
  updateSingleChecked(): void {
    if (this.checkOptionsOne.every(item => !item.checked)) {
      this.allChecked = false;
      this.indeterminate = false;
    } else if (this.checkOptionsOne.every(item => item.checked)) {
      this.allChecked = true;
      this.indeterminate = false;
    } else {
      this.indeterminate = true;
    }
  }
}
