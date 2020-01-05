import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { LeaveStatisticalAnalysisComponent } from './leave-statistical-analysis/leave-statistical-analysis.component';
import { LeaveProcessComponent } from './leave-process/leave-process.component';
import { LeaveReportComponent } from './leave-report/leave-report.component';
import { LeaveDetailComponent } from '@shared/component/leave-detail/leave-detail.component';

const routes: Routes = [
  { path: 'leave-statistical-analysis', component: LeaveStatisticalAnalysisComponent },
  { path: 'leave-process', component: LeaveProcessComponent },
  { path: 'leave-report', component: LeaveReportComponent },
  { path: 'leave-detail', component: LeaveDetailComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LeaveRoutingModule {}
