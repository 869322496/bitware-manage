import { LeaveService } from '@shared/service/leave.service';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { UserInfo } from '@shared/entity/UserInfo.entity';
import { Component, OnInit, Input, OnChanges, SimpleChanges, Output, EventEmitter } from '@angular/core';
import { SysService } from '@shared/service/sys.service';
import { pluck } from 'rxjs/operators';

@Component({
  selector: 'app-vacation-detail',
  templateUrl: './vacation-detail.component.html',
  styleUrls: ['./vacation-detail.component.less'],
})
export class VacationDetailComponent implements OnInit, OnChanges {
  isLoading: boolean = false;
  userList: SelectOption[] = [];
  annualLeaveOption: any;
  @Input() userId: string = 'all';
  @Output() emitAnnualLeave: EventEmitter<any> = new EventEmitter();
  constructor(private sysService: SysService, private leaveService: LeaveService) {}

  ngOnInit() {
    /* this.getUserList(); */
  }

  ngOnChanges(changes: SimpleChanges): void {
    this.getAnnualLeave();
  }

  /**
   *获取员工年假分析数据
   * @author ludaxian
   * @date 2020-01-16
   * @param {*} userId
   */
  getAnnualLeave() {
    this.isLoading = true;
    this.leaveService
      .getAnnualLeave(this.userId)
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          return;
        }
        this.emitAnnualLeave.emit(res);
        this.annualLeaveOption = {
          tooltip: {
            formatter: '{a} <br/>{b} : {c}%',
          },
          toolbox: {
            feature: {
              /*    restore: {}, */
              saveAsImage: {},
            },
          },

          series: [
            {
              axisLine: {
                // 坐标轴线
                lineStyle: {
                  // 属性lineStyle控制线条样式
                  color: [
                    [0.33333, '#52c41a'],
                    [0.666666666, '#ffc700'],
                    [1, '#f5222d'],
                  ],
                  shadowColor: '#666', //默认透明
                  shadowBlur: 40,
                  width: 20,
                },
              },
              axisLabel: {
                fontSize: 20,
              },
              title: {
                value: '1',
                color: '000',
              },
              pointer: {
                width: 5,
                shadowColor: '#fff', //默认透明
                shadowBlur: 5,
              },
              splitLine: {
                // 分隔线
                length: 20, // 属性length控制线长
                lineStyle: {
                  // 属性lineStyle（详见lineStyle）控制线条样式
                  width: 3,
                  color: '#fff',
                  shadowColor: '#fff', //默认透明
                  shadowBlur: 10,
                },
              },
              splitNumber: res[0]['annualLeaveSum'] == 0 ? null : res[0]['annualLeaveSum'],
              axisTick: {
                show: false,
              },
              min: 0,
              max: res[0]['annualLeaveSum'],
              name: '剩余假期',
              type: 'gauge',
              detail: {
                formatter: `还剩${
                  Number(res[0]['annualLeaveSum']) - Number(res[0]['finishLeaveSum']) < 0
                    ? 0
                    : Number(res[0]['annualLeaveSum']) - Number(res[0]['finishLeaveSum'])
                }天`,
                fontSize: 20,
                fontWeight: 600,
              },
              data: [{ value: res[0]['finishLeaveSum'], name: '剩余假期' }],
            },
          ],
        };
      })
      .finally(() => {
        this.isLoading = false;
      });
  }
}
