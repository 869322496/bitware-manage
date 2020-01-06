import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, NzTabChangeEvent } from 'ng-zorro-antd';
import { _HttpClient, SettingsService } from '@delon/theme';
import { STColumn } from '@delon/abc';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { LeaveService } from 'src/app/routes/leave/leave.service';
import { pluck } from 'rxjs/operators';
import { LeaveAudit } from '@shared/entity/LeaveAudit.enetity';
import { Step } from '@shared/entity/Step.entity';
import { BitService } from '@shared/Bit.service';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';

@Component({
  selector: 'leave-detail',
  templateUrl: './leave-detail.component.html',
  styleUrls: ['./leave-detail.component.less'],
})
export class LeaveDetailComponent implements OnInit {
  list: any[] = [];

  data = {
    advancedOperation1: [],
    advancedOperation2: [],
    advancedOperation3: [],
  };

  opColumns: STColumn[] = [
    { title: '操作类型', index: 'type' },
    { title: '操作人', index: 'name' },
    { title: '执行结果', index: 'status', render: 'status' },
    { title: '操作时间', index: 'updatedAt', type: 'date' },
    { title: '备注', index: 'memo', default: '-' },
  ];
  leave: LeaveInfo = new LeaveInfo();
  leaveList: LeaveInfo[] = [];
  leaveProcess: LeaveAudit[] = [];
  steps: Step[] = [];
  constructor(
    public msg: NzMessageService,
    private leaveService: LeaveService,
    private settingService: SettingsService,
    private bitService: BitService,
  ) {}

  ngOnInit() {
    this.getLeaveList();
  }

  /**
   * 生成进度
   * @param leaveAudits
   */
  createLeaveProcess(leaveAudits: LeaveAudit[]) {
    this.steps = [];
    this.steps = [new Step(this.leave.userName, 'finish', this.leave.createTime, '提交假单', 'check-circle', false)];
    this.bitService
      .getDictionary('AuditType', 'all')
      .pipe(pluck('data'))
      .toPromise()
      .then((res: DictionaryItem[]) => {
        this.steps = [...this.steps, ...res.map(item => new Step(null, 'wait', null, item.name, 'close-circle', true))];
        const lastStep = leaveAudits.find(item => item.typeName === this.steps[this.steps.length - 1].title);
        if (lastStep.status === 1) {
          // 若通过
          this.steps = [...this.steps, new Step(null, 'finish', null, '完成', 'check-circle', false)];
        } else {
          this.steps = [...this.steps, new Step(null, 'wait', null, '完成', null, false)];
        }
        this.steps.forEach(item => {
          const tmp = leaveAudits.find(audit => audit.typeName === item.title);
          if (tmp) {
            switch (tmp.status) {
              case 0:
                /*    item.userName = tmp.auditorName; */
                item.status = 'process';
                item.icon = 'loading';
                break;
              case 1:
                /*  if(tmp) */
                item.userName = tmp.auditorName;
                item.status = 'finish';
                item.icon = 'check-circle';
                item.time = tmp.time;
                break;
              case 2:
                item.userName = tmp.auditorName;
                item.status = 'error';
                item.icon = 'close-circle';
                item.time = tmp.time;
                break;
            }
          }
        });
      });
  }

  /**
   * 获取请假列表
   */
  getLeaveList() {
    this.leaveService
      .getLeaveDetailByUserId(this.settingService.user.id)
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.leaveList = res;
        this.leave = this.leaveList[0];
        this.createLeaveProcess(this.leave.leaveProcess);
      });
  }

  change(args: NzTabChangeEvent) {
    this.list = this.data[`advancedOperation${args.index + 1}`];
  }
}
