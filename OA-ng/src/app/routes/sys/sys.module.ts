import { NgModule } from '@angular/core';
import { SharedModule } from '@shared';
import { NgxEchartsModule } from 'ngx-echarts';
import { RolePermissionComponent } from './role-permission/role-permission.component';
import { SysRoutingModule } from './sys-routing.module';
import { StartupService } from '@core/startup/startup.service';
import { UserManageComponent } from './user-manage/user-manage.component';

const COMPONENTS = [RolePermissionComponent];
const COMPONENTS_NOROUNT = [];

@NgModule({
  imports: [SharedModule, NgxEchartsModule, SysRoutingModule],
  declarations: [...COMPONENTS, ...COMPONENTS_NOROUNT, UserManageComponent],
  providers: [StartupService],
  entryComponents: COMPONENTS_NOROUNT,
})
export class SysModule {}
