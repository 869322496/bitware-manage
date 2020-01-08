import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { LeaveDetailComponent } from '@shared/component/leave-detail/leave-detail.component';
import { RouteguardService } from '../routeguard.service';
import { RolePermissionComponent } from './role-permission/role-permission.component';
import { NzIconModule } from 'ng-zorro-antd/icon';
const routes: Routes = [
  {
    path: 'role-permission',
    component: RolePermissionComponent,
    canActivate: [RouteguardService],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes), NzIconModule],
  exports: [RouterModule],
})
export class SysRoutingModule {}
