import { Injectable, Inject } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { SettingsService, MenuService } from '@delon/theme';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class RouteguardService implements CanActivate {
  constructor(
    private router: Router,
    private settingService: SettingsService,
    private menuService: MenuService,
    private httpClient: HttpClient,
  ) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean | Promise<boolean> {
    const menu = this.menuService.menus[0];
    if (menu.children === undefined || menu.children.length === 0) {
      this.router.navigateByUrl('/passport/login');
      return false;
    }
    const name = this.settingService.user.name;
    if (name === undefined || name === null) {
      this.router.navigateByUrl('/passport/login');
      return false;
    }
    return true;
  }
  /*     return this.httpClient
      .get('/basic/verifylogin')
      .toPromise()
      .then(result => {
        const val = result as boolean;
        if (!val) {
          this.router.navigateByUrl('/passport/login');
        }
        return val;
      });
  } */
}
