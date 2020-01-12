import { Component, OnDestroy, OnInit, ChangeDetectorRef, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import {
  NzMessageService,
  isTemplateRef,
  NzFormatEmitEvent,
  NzModalService,
  NzTreeComponent,
  NzTreeNode,
} from 'ng-zorro-antd';
import { _HttpClient, SettingsService, MenuService } from '@delon/theme';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { pluck, mergeMap } from 'rxjs/operators';
import { BitService } from '@shared/service/Bit.service';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { differenceInDays, startOfDay, endOfDay, format } from 'date-fns';
import { ResourceInfo } from '@shared/entity/ResourceInfo.entity';
import { RoleInfo } from '@shared/entity/RoleInfo.entity';
import { SysService } from '../../../shared/service/sys.service';
import { Tree } from '@shared/entity/Tree.entity';
import { StartupService } from '@core/startup/startup.service';
import { EditRoleComponent } from '@shared/component/edit-role/edit-role.component';

@Component({
  selector: 'role-permission',
  templateUrl: './role-permission.component.html',
  styleUrls: ['./role-permission.component.less'],
})
export class RolePermissionComponent implements OnInit {
  @ViewChild('tree', { static: true }) tree;
  @ViewChild('myTree', { static: false }) myTree: NzTreeComponent;
  roleList: RoleInfo[] = [];
  isLoading: boolean = false;
  isTreeLoading: boolean = false;
  defaultCheckedKeys: string[] = [];
  /*  defaultExpandedKeys = ['0-0', '0-0-0', '0-0-1'];  */

  nodes: Tree[] = [];
  treeType: string;
  treeRole: string;
  constructor(
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef,
    private router: Router,
    public http: _HttpClient,
    public msg: NzMessageService,
    private bitService: BitService,
    private sysService: SysService,
    public modalService: NzModalService,
    private settingService: SettingsService,
    private startupService: StartupService,
    private menuService: MenuService,
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
        this.roleList = res;
      });
  }

  /**
   *新增角色
   *
   * @author ludaxian
   * @date 2020-01-12
   */
  addRole() {
    this.modalService.create({
      nzTitle: '新增角色',
      nzContent: EditRoleComponent,
      nzWidth: 600,
      nzFooter: null,
      nzComponentParams: {
        orderNo: this.roleList.length,
      },
    });
  }
  /**
   *设置权限
   *
   * @author ludaxian
   * @date 2020-01-09
   * @param {string} type
   * @param {RoleInfo} data
   */
  setPermissionOrMenu(type: string, data: RoleInfo) {
    this.isTreeLoading = true;
    this.treeType = type;
    this.treeRole = data.id;
    this.sysService
      .getResourceByCategory(type)
      .pipe(
        pluck('data'),
        mergeMap(permisson => {
          this.nodes = permisson;
          this.modalService.create({
            nzTitle: type == 'func' ? '设置权限' : '设置菜单',
            nzContent: this.tree,
            nzFooter: null,
            nzWidth: 500,
            nzComponentParams: {
              type: type,
            },
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

  /**
   *
   * 保存资源
   * @author ludaxian
   * @date 2020-01-08
   */
  save() {
    let tmp: NzTreeNode[] = [];
    let resourceArr: string[] = [];
    const format = (tree: NzTreeNode[]) => {
      if (tree.length === 0) return;
      tree.forEach(item => {
        tmp = [...tmp, item];
        if (item['_children'].length > 0) {
          format(item['_children']);
        }
      });
      return tmp;
    };
    const oneArr = format(this.myTree.getTreeNodes());
    const allLeafAndCheckedResource = oneArr.filter(item => item.isChecked && item.isLeaf);
    if (this.treeType === 'func') {
      resourceArr = allLeafAndCheckedResource.map(item => item['origin']['key']);
    } else if (this.treeType === 'menu') {
      let allMenu = [];
      allLeafAndCheckedResource.forEach(item => {
        allMenu = [...allMenu, item.key];
        const getParentMenu = (node: NzTreeNode) => {
          if (!node) return;
          allMenu = [...allMenu, node.key];
          if (node.parentNode) {
            getParentMenu(node.parentNode);
          }
        };
        getParentMenu(item);
      });
      resourceArr = Array.from(new Set(allMenu));
    }
    this.isLoading = true;
    this.sysService
      .insertRoleResource(this.treeRole, this.treeType, resourceArr)
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          this.msg.error(res['errorMessage']);
          return;
        }
        this.msg.success('设置角色资源成功!');
        this.initApp().then(res => {
          this.menuService.openedByUrl('/sys/role-permission', true);
        });
        this.modalService.closeAll();
      })
      .finally(() => {
        this.isLoading = false;
      });
  }
  /**
   *
   * 调整资源后重置权限和菜单
   * @author ludaxian
   * @date 2020-01-08
   * @returns {Promise<any>}
   */
  initApp(): Promise<any> {
    return new Promise((resolve, reject) => {
      this.startupService.initHttp(resolve, reject);
    });
  }
}
