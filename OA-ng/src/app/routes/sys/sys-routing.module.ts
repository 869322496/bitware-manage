import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { RouteguardService } from '../routeguard.service';
import { RolePermissionComponent } from './role-permission/role-permission.component';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { UserManageComponent } from './user-manage/user-manage.component';
const routes: Routes = [
  {
    path: 'role-permission',
    component: RolePermissionComponent,
    canActivate: [RouteguardService],
  },
  {
    path: 'user-manage',
    component: UserManageComponent,
    canActivate: [RouteguardService],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes), NzIconModule],
  exports: [RouterModule],
})
export class SysRoutingModule {}
