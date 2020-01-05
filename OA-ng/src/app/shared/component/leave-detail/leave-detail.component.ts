import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, NzTabChangeEvent } from 'ng-zorro-antd';
import { _HttpClient, SettingsService } from '@delon/theme';
import { STColumn } from '@delon/abc';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { LeaveService } from 'src/app/routes/leave/leave.service';
import { pluck } from 'rxjs/operators';

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
  constructor(
    public msg: NzMessageService,
    private leaveService: LeaveService,
    private settingService: SettingsService,
  ) {}

  ngOnInit() {
    this.getLeaveList();
  }

  /**
   * 获取请假列表
   */
  getLeaveList() {
    this.leaveService
      .getLeaveByUserId(this.settingService.user.id)
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.leaveList = res;
        this.leave = this.leaveList[0];
      });
  }

  change(args: NzTabChangeEvent) {
    this.list = this.data[`advancedOperation${args.index + 1}`];
  }
}
