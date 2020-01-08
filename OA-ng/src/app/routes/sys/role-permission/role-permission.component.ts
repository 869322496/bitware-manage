import { Component, OnDestroy, OnInit, ChangeDetectorRef, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService, isTemplateRef, NzFormatEmitEvent, NzModalService } from 'ng-zorro-antd';
import { _HttpClient, SettingsService } from '@delon/theme';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { pluck, mergeMap } from 'rxjs/operators';
import { BitService } from '@shared/service/Bit.service';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { differenceInDays, startOfDay, endOfDay } from 'date-fns';
import { ResourceInfo } from '@shared/entity/ResourceInfo.entity';
import { RoleInfo } from '@shared/entity/RoleInfo.entity';
import { SysService } from '../../../shared/service/sys.service';
import { Tree } from '@shared/entity/Tree.entity';

@Component({
  selector: 'role-permission',
  templateUrl: './role-permission.component.html',
  styleUrls: ['./role-permission.component.less'],
})
export class RolePermissionComponent implements OnInit {
  @ViewChild('tree', { static: true }) tree;
  RoleList: RoleInfo[] = [];
  isLoading: boolean = false;
  isTreeLoading: boolean = false;
  defaultCheckedKeys: string[] = [];
  /*  defaultExpandedKeys = ['0-0', '0-0-0', '0-0-1'];  */

  nodes: Tree[] = [];

  constructor(
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef,
    private router: Router,
    public http: _HttpClient,
    public msg: NzMessageService,
    private bitService: BitService,
    private sysService: SysService,
    private modal: NzModalService,
    private settingService: SettingsService,
  ) {}
  ngOnInit(): void {
    this.getRoleList();
  }

  /**
   *
   * 获取角色列表
   * @author ludaxian
   * @date 2020-01-08
   */
  getRoleList() {
    this.sysService
      .getRoleList()
      .pipe(pluck('data'))
      .toPromise()
      .then(res => {
        this.RoleList = res;
      });
  }

  /**
   *
   * 设置权限
   * @author ludaxian
   * @date 2020-01-08
   * @param data
   */
  setPermissionOrMenu(type: string, data: RoleInfo) {
    this.isTreeLoading = true;
    this.sysService
      .getResourceByCategory(type)
      .pipe(
        pluck('data'),
        mergeMap(permisson => {
          this.nodes = permisson;
          this.modal.create({
            nzTitle: type == 'func' ? '设置权限' : '设置菜单',
            nzContent: this.tree,
            nzFooter: null,
            nzWidth: 500,
          });
          return this.sysService.getResourceByRoleId(data.id, type);
        }),
        pluck('data'),
      )
      .toPromise()
      .then((res: ResourceInfo[]) => {
        const leafNodes = this.bitService
          .formatTreeToArr(this.nodes)
          .filter(item1 => item1.isLeaf)
          .map(item => item.key);
        this.defaultCheckedKeys = [...res.filter(item => leafNodes.includes(item.id)).map(item1 => item1.id)];
      })
      .finally(() => {
        this.isTreeLoading = false;
      });
  }

  nzEvent(event: NzFormatEmitEvent): void {
    console.log(event);
  }
}
