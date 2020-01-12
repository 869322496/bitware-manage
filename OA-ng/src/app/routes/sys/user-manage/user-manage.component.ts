import { Component, OnInit, ViewChild } from '@angular/core';
import { pluck } from 'rxjs/operators';
import { UserInfo } from '@shared/entity/UserInfo.entity';
import { SysService } from '@shared/service/sys.service';
import { NzModalService, NzMessageService } from 'ng-zorro-antd';
import { EditUserComponent } from '@shared/component/edit-user/edit-user.component';
import { RoleInfo } from '@shared/entity/RoleInfo.entity';

@Component({
  selector: 'app-user-manage',
  templateUrl: './user-manage.component.html',
  styleUrls: ['./user-manage.component.less'],
})
export class UserManageComponent implements OnInit {
  @ViewChild('roleTpl', { static: false }) roleTpl;
  userList: UserInfo[] = [];
  roleList: RoleInfo[] = [];
  isLoading: boolean = false;
  isEditing: boolean = false;
  editUser: UserInfo = new UserInfo();
  constructor(private sysService: SysService, private modal: NzModalService, private msg: NzMessageService) {}
  ngOnInit() {
    this.getUserList();
  }
  /**
   *
   * 获取角色列表
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
        this.userList = res;
      })
      .finally(() => {
        this.isLoading = false;
      });
  }

  /**
   *
   * 获取角色列表
   * @author ludaxian
   * @date 2020-01-12
   */
  getRoleList() {
    this.sysService
      .getRoleList()
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.roleList = res;
      });
  }
  /**
   *设置用户角色
   *
   * @author ludaxian
   * @date 2020-01-12
   * @param {UserInfo} user
   */
  setRole(user: UserInfo) {
    this.editUser = user;
    this.getRoleList();
    this.modal.create({
      nzTitle: '设置角色',
      nzContent: this.roleTpl,
      nzWidth: 800,
      nzFooter: null,
    });
  }

  /**
   *
   *新增用户
   * @author ludaxian
   * @date 2020-01-12
   */
  addUser() {
    this.modal
      .create({
        nzTitle: '新增用户',
        nzContent: EditUserComponent,
        nzFooter: null,
        nzWidth: 600,
      })
      .afterClose.subscribe(res => {
        if (res) {
          this.getUserList();
        }
      });
  }

  /**
   *
   *角色提交
   * @author ludaxian
   * @date 2020-01-12
   */
  submitRole() {
    this.sysService
      .updateUserRole([
        {
          userId: this.editUser.id,
          roleId: this.editUser.roleId,
        },
      ])
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          this.msg.warning(res['errorMessage']);
          return;
        }
        this.msg.success('设置角色成功！');
        this.modal.closeAll();
        this.getUserList();
      });
  }
}
