import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { BitResult } from '@shared/entity/BitResult.entity';
import { LeaveAudit } from '@shared/entity/LeaveAudit.enetity';
import { SettingsService } from '@delon/theme';
import { UserInfo } from '@shared/entity/UserInfo.entity';
import { RoleInfo } from '@shared/entity/RoleInfo.entity';

@Injectable({ providedIn: 'root' })
export class SysService {
  private getRoleListUrl = 'OA/security/getRoleList';
  private getResourceByCategoryUrl = 'OA/security/getResourceByCategory';
  private getResourceByRoleIdUrl = 'OA/security/getResourceByRoleId';
  private insertRoleResourceUrl = 'OA/security/insertRoleResource';
  private getUserListUrl = 'OA/security/getUserList';
  private insertUserUrl = 'OA/security/insertUser';
  private updateUserRoleUrl = 'OA/security/updateUserRole';
  private insertRoleUrl = 'OA/security/insertRole';
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

  /**
   *
   * 设置角色资源 增删改
   * @author ludaxian
   * @date 2020-01-08
   * @param {string} roleId
   * @param {string} category
   * @param {string[]} resourceIds
   * @returns {Observable<BitResult>}
   */
  insertRoleResource(roleId: string, category: string, resourceIds: string[]): Observable<BitResult> {
    return this.http.post<BitResult>(this.insertRoleResourceUrl, {
      roleId: roleId,
      category: category,
      resourceIds: resourceIds,
    });
  }

  /**
   *  获取用户列表
   * @returns {Observable<BitResult>}
   * @memberof SysService
   */
  getUserList(): Observable<BitResult> {
    return this.http.get<BitResult>(this.getUserListUrl);
  }

  /**
   *
   *新增用户
   * @author ludaxian
   * @date 2020-01-12
   * @param {UserInfo} user
   * @returns {Observable<BitResult>}
   */
  insertUser(user: UserInfo): Observable<BitResult> {
    return this.http.post<BitResult>(this.insertUserUrl, user, this.httpOptions);
  }

  /**
   *  更新设置用户角色
   * @author ludaxian
   * @date 2020-01-12
   * @param {string} userId
   * @param {string} roleId
   * @returns
   */
  updateUserRole(userRoleList: { userId: string; roleId: string }[]) {
    return this.http.put<BitResult>(this.updateUserRoleUrl, userRoleList, this.httpOptions);
  }

  /**
   *  新增角色
   *
   * @author ludaxian
   * @date 2020-01-12
   * @param {RoleInfo} role
   * @returns {Observable<BitResult>}
   */
  insertRole(roleList: RoleInfo[]): Observable<BitResult> {
    return this.http.post<BitResult>(this.insertRoleUrl, roleList, this.httpOptions);
  }
}
