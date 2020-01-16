import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
// delon
import { AlainThemeModule } from '@delon/theme';
import { DelonABCModule } from '@delon/abc';
import { DelonACLModule } from '@delon/acl';
import { DelonFormModule } from '@delon/form';
// i18n
import { TranslateModule } from '@ngx-translate/core';

// #region third libs
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { CountdownModule } from 'ngx-countdown';
import { LeaveDetailComponent } from './component/leave-detail/leave-detail.component';
import { EditUserComponent } from './component/edit-user/edit-user.component';
import { IsEmptyPipe } from './pipe/IsEmpty.pipe';
import { EditRoleComponent } from './component/edit-role/edit-role.component';
import { VacationDetailComponent } from './component/vacation-detail/vacation-detail.component';
import { NgxEchartsModule } from 'ngx-echarts';
const THIRDMODULES = [NgZorroAntdModule, CountdownModule];
// #endregion

// #region your componets & directives
const COMPONENTS = [LeaveDetailComponent, EditUserComponent, EditRoleComponent, VacationDetailComponent];
const DIRECTIVES = [];
// #endregion

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    ReactiveFormsModule,
    AlainThemeModule.forChild(),
    DelonABCModule,
    DelonACLModule,
    DelonFormModule,
    // third libs
    ...THIRDMODULES,
    NgxEchartsModule,
  ],
  entryComponents: [...COMPONENTS],
  declarations: [
    // your components
    ...COMPONENTS,
    ...DIRECTIVES,
    IsEmptyPipe,
  ],
  exports: [
    IsEmptyPipe,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    AlainThemeModule,
    DelonABCModule,
    DelonACLModule,
    DelonFormModule,
    // i18n
    TranslateModule,
    // third libs
    ...THIRDMODULES,
    // your components
    ...COMPONENTS,
    ...DIRECTIVES,
  ],
})
export class SharedModule {}
