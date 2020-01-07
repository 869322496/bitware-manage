import { Injectable, Injector, Inject } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { zip, forkJoin } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { MenuService, SettingsService, TitleService, ALAIN_I18N_TOKEN } from '@delon/theme';
import { DA_SERVICE_TOKEN, ITokenService, JWTTokenModel } from '@delon/auth';
import { ACLService } from '@delon/acl';
import { TranslateService } from '@ngx-translate/core';
import { I18NService } from '../i18n/i18n.service';

import { NzIconService } from 'ng-zorro-antd/icon';
import { ICONS_AUTO } from '../../../style-icons-auto';
import { ICONS } from '../../../style-icons';

/**
 * Used for application startup
 * Generally used to get the basic data of the application, like: Menu Data, User Data, etc.
 */
@Injectable()
export class StartupService {
  constructor(
    iconSrv: NzIconService,
    private menuService: MenuService,
    private translate: TranslateService,
    @Inject(ALAIN_I18N_TOKEN) private i18n: I18NService,
    private settingService: SettingsService,
    private aclService: ACLService,
    private titleService: TitleService,
    @Inject(DA_SERVICE_TOKEN) private tokenService: ITokenService,
    private httpClient: HttpClient,
    private injector: Injector,
    private aCLService: ACLService,
  ) {
    iconSrv.addIcon(...ICONS_AUTO, ...ICONS);
    this.translate.setDefaultLang(this.i18n.defaultLang);
  }
  mockMenu = [
    {
      text: '导航',
      /*   i18n: 'menu.pro', */
      /*    group: false,
      hideInBreadcrumb: true, */
      children: [
        {
          text: '首页',
          /*        i18n: 'menu.form', */
          link: '/dashboard',
          children: [],
          /*   icon: 'anticon-edit', */
        },
        {
          text: '请假管理',
          /*        i18n: 'menu.form', */
          /*   link: '/leave/form', */
          icon: 'anticon-edit',
          children: [
            {
              text: '请假统计分析',
              link: '/leave/leave-statistical-analysis',

              /*          i18n: 'menu.form.basicform', */
              /*          shortcut: true, */
            },

            {
              text: '请假上报处理',
              link: '/leave/leave-process',
              /*   reuse: true, */
              /*     i18n: 'menu.form.stepform', */
            },
            {
              text: '请假上报',
              link: '/leave/leave-report',
              /*   reuse: true, */
              /*     i18n: 'menu.form.stepform', */
            },
            {
              text: '请假详情',
              link: '/leave/leave-detail',
              /*   reuse: true, */
              /*     i18n: 'menu.form.stepform', */
            },
          ],
        },
        {
          text: 'List',
          i18n: 'menu.list',
          icon: 'anticon-appstore',
          children: [
            {
              text: 'Table List',
              link: '/pro/list/table-list',
              i18n: 'menu.list.searchtable',
              /*     shortcut: true, */
            },
            {
              text: 'Basic List',
              link: '/pro/list/basic-list',
              i18n: 'menu.list.basiclist',
            },
            {
              text: 'Card List',
              link: '/pro/list/card-list',
              i18n: 'menu.list.cardlist',
            },
            {
              text: 'Search List',
              i18n: 'menu.list.searchlist',
              children: [
                {
                  link: '/pro/list/articles',
                  i18n: 'menu.list.searchlist.articles',
                },
                {
                  link: '/pro/list/projects',
                  i18n: 'menu.list.searchlist.projects',
                  /*    shortcut: true, */
                },
                {
                  link: '/pro/list/applications',
                  i18n: 'menu.list.searchlist.applications',
                },
              ],
            },
          ],
        },
      ],
    },
  ];
  private initHttp(resolve: any, reject: any) {
    forkJoin([
      this.httpClient.get('OA/security/initApp'),
      this.httpClient.get('OA/share/getMenu/' + this.settingService.user.roleId),
    ])
      .toPromise()
      .then((res: any) => {
        this.settingService.setApp(res[0].data.app);
        this.titleService.suffix = res[0].data.app.name;
        this.menuService.add(res[1].data);
        /*    this.settingService.setUser(this.tokenService.get()); */
        this.aclService.setFull(true);
        this.aCLService.setRole([this.settingService.user.role]);
        console.log(this.aCLService.data);
      })
      .catch(err => console.log(err))
      .finally(() => resolve(null));
  }

  load(): Promise<any> {
    // only works with promises
    // https://github.com/angular/angular/issues/15088
    return new Promise((resolve, reject) => {
      // http
      this.initHttp(resolve, reject);
      // mock：请勿在生产环境中这么使用，viaMock 单纯只是为了模拟一些数据使脚手架一开始能正常运行
      /*    this.viaMockI18n(resolve, reject); */
    });
  }
}
