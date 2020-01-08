import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { BitResult } from '@shared/entity/BitResult.entity';
import { LeaveAudit } from '@shared/entity/LeaveAudit.enetity';

@Injectable({ providedIn: 'root' })
export class LeaveService {
  private insertLeaveUrl = 'OA/leave/insertLeave';
  private getLeaveDetailByIdUrl = 'OA/leave/getLeaveDetailById';
  private getLeaveDetailByUserIdUrl = 'OA/leave/getLeaveDetailByUserId';
  private getAuditLeaveUrl = 'OA/leave/getAuditLeave';
  private auditLeaveUrl = 'OA/leave/auditLeave';
  constructor(private http: HttpClient) {}
  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
    }),
  };
  /**
   *
   * @param dicCode all获取全部
   * @param dicItemCode all获取全部
   */
  insertLeave(leave: LeaveInfo): Observable<BitResult> {
    return this.http.post<BitResult>(this.insertLeaveUrl, leave, this.httpOptions);
  }

  /**
   * 获取某条请假信息
   * @param id
   */
  getLeaveDetailById(id?: string): Observable<BitResult> {
    return this.http.get<BitResult>(this.getLeaveDetailByIdUrl + '/' + (id ? id : 'all'));
  }

  /**
   * 获取某位用户请假信息
   * @param userId
   */
  getLeaveDetailByUserId(userId?: string): Observable<BitResult> {
    return this.http.get<BitResult>(this.getLeaveDetailByUserIdUrl + '/' + (userId ? userId : 'all'));
  }
  /**
   * 获取当前登录角色权限审核的请假单
   */
  getAuditLeave(): Observable<BitResult> {
    return this.http.get<BitResult>(this.getAuditLeaveUrl);
  }

  /**
   * 审核请假
   * @param audits
   */
  auditLeave(audits: LeaveAudit[]): Observable<BitResult> {
    return this.http.post<BitResult>(this.auditLeaveUrl, audits, this.httpOptions);
  }
}