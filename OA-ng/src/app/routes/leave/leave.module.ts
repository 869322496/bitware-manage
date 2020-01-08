import { NgModule } from '@angular/core';
import { SharedModule } from '@shared';
import { LeaveProcessComponent } from './leave-process/leave-process.component';
import { LeaveStatisticalAnalysisComponent } from './leave-statistical-analysis/leave-statistical-analysis.component';
import { LeaveRoutingModule } from './leave-routing.module';
import { NgxEchartsModule } from 'ngx-echarts';
import { LeaveReportComponent } from './leave-report/leave-report.component';
import { LeaveService } from '../../shared/service/leave.service';
const COMPONENTS = [LeaveProcessComponent, LeaveStatisticalAnalysisComponent, LeaveReportComponent];
const COMPONENTS_NOROUNT = [];

@NgModule({
  imports: [SharedModule, LeaveRoutingModule, NgxEchartsModule],
  declarations: [...COMPONENTS, ...COMPONENTS_NOROUNT],
  providers: [],
  entryComponents: COMPONENTS_NOROUNT,
})
export class LeaveModule {}
