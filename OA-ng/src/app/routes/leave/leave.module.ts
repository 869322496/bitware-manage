import { NgModule } from '@angular/core';
import { SharedModule } from '@shared';
import { LeaveProcessComponent } from './leave-process/leave-process.component';
import { LeaveStatisticalAnalysisComponent } from './leave-statistical-analysis/leave-statistical-analysis.component';
import { LeaveRoutingModule } from './leave-routing.module';
import { NgxEchartsModule } from 'ngx-echarts';
import { LeaveReportComponent } from './leave-report/leave-report.component';
import { LeaveService } from '../../shared/service/leave.service';
import { MyLeaveComponent } from './my-leave/my-leave.component';
import { LeaveSuppleComponent } from './leave-supple/leave-supple.component';
const COMPONENTS = [
  LeaveProcessComponent,
  LeaveSuppleComponent,
  LeaveStatisticalAnalysisComponent,
  LeaveReportComponent,
  MyLeaveComponent,
];
const COMPONENTS_NOROUNT = [];

@NgModule({
  imports: [SharedModule, LeaveRoutingModule, NgxEchartsModule],
  declarations: [...COMPONENTS, ...COMPONENTS_NOROUNT],
  providers: [],
  entryComponents: COMPONENTS_NOROUNT,
})
export class LeaveModule {}
