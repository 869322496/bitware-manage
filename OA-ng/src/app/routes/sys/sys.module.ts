import { NgModule } from '@angular/core';
import { SharedModule } from '@shared';
import { NgxEchartsModule } from 'ngx-echarts';
import { RolePermissionComponent } from './role-permission/role-permission.component';
import { SysRoutingModule } from './sys-routing.module';
import { StartupService } from '@core/startup/startup.service';

const COMPONENTS = [RolePermissionComponent];
const COMPONENTS_NOROUNT = [];

@NgModule({
  imports: [SharedModule, NgxEchartsModule, SysRoutingModule],
  declarations: [...COMPONENTS, ...COMPONENTS_NOROUNT],
  providers: [StartupService],
  entryComponents: COMPONENTS_NOROUNT,
})
export class SysModule {}
