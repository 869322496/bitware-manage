import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { BitResult } from '@shared/entity/BitResult.entity';
import { LeaveAudit } from '@shared/entity/LeaveAudit.enetity';
import { SettingsService } from '@delon/theme';

@Injectable({ providedIn: 'root' })
export class SysService {
  private getRoleListUrl = 'OA/security/getRoleList';
  private getResourceByCategoryUrl = 'OA/security/getResourceByCategory';
  private getResourceByRoleIdUrl = 'OA/security/getResourceByRoleId';
  constructor(private http: HttpClient, private settingService: SettingsService) {}
  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
    }),
  };

  /**
   * 获取角色列表
   */
  getRoleList(): Observable<BitResult> {
    return this.http.get<BitResult>(this.getRoleListUrl);
  }

  /**
   *获取所有资源树
   *
   * @author ludaxian
   * @date 2020-01-08
   * @returns
   */
  getResourceByCategory(category: string): Observable<BitResult> {
    return this.http.get<BitResult>(this.getResourceByCategoryUrl + '/' + category);
  }

  /**
   *  根据roleId获取其拥有的资源
   * @author ludaxian
   * @date 2020-01-08
   * @param role
   * @param category
   * @returns
   */
  getResourceByRoleId(role: string, category: string): Observable<BitResult> {
    return this.http.get<BitResult>(this.getResourceByRoleIdUrl + '/' + role + '/' + category);
  }
}
