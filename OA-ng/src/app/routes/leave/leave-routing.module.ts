import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { LeaveStatisticalAnalysisComponent } from './leave-statistical-analysis/leave-statistical-analysis.component';
import { LeaveProcessComponent } from './leave-process/leave-process.component';
import { LeaveReportComponent } from './leave-report/leave-report.component';
import { LeaveDetailComponent } from '@shared/component/leave-detail/leave-detail.component';
import { RouteguardService } from '../routeguard.service';

const routes: Routes = [
  {
    path: 'leave-statistical-analysis',
    component: LeaveStatisticalAnalysisComponent,
    canActivate: [RouteguardService],
  },
  { path: 'leave-process', component: LeaveProcessComponent, canActivate: [RouteguardService] },
  { path: 'leave-report', component: LeaveReportComponent, canActivate: [RouteguardService] },
  { path: 'leave-detail', component: LeaveDetailComponent, canActivate: [RouteguardService] },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LeaveRoutingModule {}
