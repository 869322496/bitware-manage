import { NgModule } from '@angular/core';
import { SharedModule } from '@shared';
import { NgxEchartsModule } from 'ngx-echarts';
import { RolePermissionComponent } from './role-permission/role-permission.component';
import { SysRoutingModule } from './sys-routing.module';

const COMPONENTS = [RolePermissionComponent];
const COMPONENTS_NOROUNT = [];

@NgModule({
  imports: [SharedModule, NgxEchartsModule, SysRoutingModule],
  declarations: [...COMPONENTS, ...COMPONENTS_NOROUNT],
  providers: [],
  entryComponents: COMPONENTS_NOROUNT,
})
export class SysModule {}
