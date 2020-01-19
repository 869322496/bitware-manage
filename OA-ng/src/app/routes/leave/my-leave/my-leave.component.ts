import { UserInfo } from '@shared/entity/UserInfo.entity';
import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, NzTabChangeEvent, UploadFile, UploadFilter } from 'ng-zorro-antd';
import { _HttpClient, SettingsService } from '@delon/theme';
import { STColumn } from '@delon/abc';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { LeaveService } from '@shared/service/leave.service';
import { pluck } from 'rxjs/operators';
import { LeaveAudit } from '@shared/entity/LeaveAudit.enetity';
import { Step } from '@shared/entity/Step.entity';
import { BitService } from '@shared/service/Bit.service';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { Observable, Observer } from 'rxjs';
@Component({
  selector: 'my-leave',
  templateUrl: './my-leave.component.html',
  styleUrls: ['./my-leave.component.less'],
})
export class MyLeaveComponent implements OnInit {
  userId: string = this.settingService.user.id;
  mySelf: UserInfo = this.settingService.user as UserInfo;
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
  isLoading = false;
  imageList = []; //照片回显双绑文件集
  //照片放大回显参数
  showUploadList = {
    showPreviewIcon: true,
    showRemoveIcon: false,
    hidePreviewIconInNonImage: true,
  };
  /**
   * 回显回调
   */
  handlePreview = (file: UploadFile) => {
    this.previewImage = file.url || file.thumbUrl;
    this.previewVisible = true;
  };
  previewImage: string | undefined = '';
  previewVisible = false;
  annulLeaveDetail: any;
  constructor(
    public msg: NzMessageService,
    private leaveService: LeaveService,
    private settingService: SettingsService,
    private bitService: BitService,
  ) {}
  /**
   *获取用户的年假情况
   *
   * @author ludaxian
   * @date 2020-01-16
   * @param {*} e
   */
  getAnnulLeave(e) {
    this.annulLeaveDetail = e[0]; /* ['annualLeaveSum'] - res[0]['finishLeaveSum']; */
  }
  ngOnInit() {
    this.getLeaveList();
  }

  /**
   * 照片回显
   */
  imageEditBackView() {
    this.imageList = [];
    if (this.leave.img && JSON.parse(this.leave.img).length > 0) {
      JSON.parse(this.leave.img).forEach(item => {
        this.imageList = [
          ...this.imageList,
          {
            uid: this.bitService.uuid(),
            name: '巡检图片',
            status: 'done',
            trueUrl: item,
            url: `${BitService.ConstUtil.ApiUrl}\/upload${item.sourceFileUrl}`,
          },
        ];
      });
    }
  }

  currentProcess(type: string) {
    if (type === 'current') {
      const current = 0;
      if (this.leave) {
        if (this.leave.status === 10) {
          return this.steps.length - 1;
        }
        return this.leave.leaveProcess ? this.leave.leaveProcess.length : 0;
      }
    } else if (type === 'status') {
      if (this.leave.status === 9) {
        return 'error';
      }
      return null;
    }
  }

  /**
   * 查看详情
   * @param leave
   */
  lookDetail(leave: LeaveInfo) {
    this.isLoading = true;
    setTimeout(() => {
      this.leave = leave;
      this.createLeaveProcess(leave.leaveProcess);

      this.isLoading = false;
    }, 500);
  }

  /**
   * 撤销申请
   * @param leave
   */
  cancelApply(leave: LeaveInfo) {
    this.isLoading = true;
    this.leaveService
      .cancelApply(leave)
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          this.msg.warning(res['errorMessage']);
          return;
        }
        this.msg
          .success('撤销申请成功！', {
            nzDuration: 1000,
          })
          .onClose.toPromise()
          .then(res => {
            this.getLeaveList();
          });
      })
      .finally(() => {
        this.isLoading = false;
      });
    /*  this.msg.info('正在开发中..暂时不能取消！'); */
  }

  /**
   * 生成进度
   * @param leaveAudits
   */
  createLeaveProcess(leaveAudits: LeaveAudit[]) {
    this.imageEditBackView();
    /*     if (this.leave.img) this.imageList = JSON.parse(this.leave.img); */
    this.steps = [];

    this.steps = [new Step(this.leave.userName, 'wait', this.leave.createTime, '提交假单', null, false)];
    if (leaveAudits.length > 0) {
      this.steps = [new Step(this.leave.userName, 'finish', this.leave.createTime, '提交假单', 'check-circle', false)];
    }
    this.bitService
      .getDictionary('AuditType', 'all')
      .pipe(pluck('data'))
      .toPromise()
      .then((res: DictionaryItem[]) => {
        this.steps = [...this.steps, ...res.map(item => new Step(null, 'wait', null, item.name, null, true))];
        const lastStep = leaveAudits.find(item => item.typeName === this.steps[this.steps.length - 1].title);
        /*  if () { */
        if (lastStep != undefined && lastStep.status === 1) {
          // 若通过
          this.steps = [...this.steps, new Step(null, 'finish', null, '已批准', 'check-circle', false)];
        } else {
          this.steps = [...this.steps, new Step(null, 'wait', null, '已批准', null, false)];
        }
        /*       }else{
          this.steps = [...this.steps, new Step(null, 'wait', null, '已批准', null, false)];
        } */

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
                item.reason = tmp.reason;
                break;
              case 2:
                item.userName = tmp.auditorName;
                item.status = 'error';
                item.icon = 'close-circle';
                item.time = tmp.time;
                item.reason = tmp.reason;
                break;
            }
          } /* else {
            item.status = 'wait';
          } */
        });
      });
  }

  /**
   * 获取请假列表
   */
  getLeaveList() {
    this.isLoading = true;
    this.leaveService
      .getLeaveDetailByUserId(this.settingService.user.id)
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.leaveList = res;

        if (this.leaveList.length > 0) {
          this.leave = this.leaveList[0];
          this.createLeaveProcess(this.leave.leaveProcess);
        } else {
          this.createLeaveProcess([]);
        }
      })
      .finally(() => {
        this.isLoading = false;
      });
  }
}
