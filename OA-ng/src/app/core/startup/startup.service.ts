import { Injectable, Injector, Inject } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { zip, forkJoin } from 'rxjs';
import { catchError, pluck } from 'rxjs/operators';
import { MenuService, SettingsService, TitleService, ALAIN_I18N_TOKEN } from '@delon/theme';
import { DA_SERVICE_TOKEN, ITokenService, JWTTokenModel } from '@delon/auth';
import { ACLService } from '@delon/acl';
import { TranslateService } from '@ngx-translate/core';
import { I18NService } from '../i18n/i18n.service';

import { NzIconService } from 'ng-zorro-antd/icon';
import { ICONS_AUTO } from '../../../style-icons-auto';
import { ICONS } from '../../../style-icons';
import { ResourceInfo } from '@shared/entity/ResourceInfo.entity';

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
    /*  iconSrv.addIcon(...ICONS_AUTO, ...ICONS); */
    this.translate.setDefaultLang(this.i18n.defaultLang);
  }
  initHttp(resolve: any, reject: any) {
    forkJoin([
      this.httpClient.get('OA/security/initApp').pipe(pluck('data')),
      this.httpClient.get('OA/security/getMenu/' + this.settingService.user.roleId).pipe(pluck('data')),
    ])
      .toPromise()
      .then((res: any) => {
        this.settingService.setApp(res[0].app);
        this.titleService.suffix = res[0].app.name;
        const mainMenu = {
          text: '菜单',
          group: false,
          hideInBreadcrumb: true,
          children: res[1][0].children,
          shortcut_root: true,
        };
        this.menuService.add([mainMenu]);
        /*    this.settingService.setUser(this.tokenService.get()); */
        /* this.aclService.setFull(true); */
        this.aCLService.setRole([res[0].userInfo.role]);
        this.aCLService.setAbility([...res[0].userAuth.map((item: ResourceInfo) => item['code'])]);
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
