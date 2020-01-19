import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { BitResult } from '@shared/entity/BitResult.entity';
import { LeaveAudit } from '@shared/entity/LeaveAudit.enetity';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';

@Injectable({ providedIn: 'root' })
export class LeaveService {
  private insertLeaveUrl = 'OA/leave/insertLeave';
  private insertLeaveSuppleUrl = 'OA/leave/insertLeaveSupple';
  private getLeaveDetailByIdUrl = 'OA/leave/getLeaveDetailById';
  private getLeaveDetailByUserIdUrl = 'OA/leave/getLeaveDetailByUserId';
  private getAuditLeaveUrl = 'OA/leave/getAuditLeave';
  private auditLeaveUrl = 'OA/leave/auditLeave';
  private isSameDayUrl = 'OA/leave/isSameDay';
  private getUserLeaveCountEchartDataUrl = 'OA/leave/getUserLeaveCountEchartData';
  private cancelApplyUrl = 'OA/leave/cancelApply';
  private getAnnualLeaveUrl = 'OA/leave/getAnnualLeave';
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
   *
   * 请假补录
   * @author ludaxian
   * @date 2020-01-17
   * @param {LeaveInfo} leave
   * @returns {Observable<BitResult>}
   */
  insertLeaveSupple(leave: LeaveInfo): Observable<BitResult> {
    return this.http.post<BitResult>(this.insertLeaveSuppleUrl, leave, this.httpOptions);
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
   * @param userId null则全部
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

  /**
   * 异步校验时间是否重叠
   * @author ludaxian
   * @date 2020-01-09
   * @param {string} userId
   * @param {number} beginTime
   * @param {number} endTime
   * @returns {Observable<BitResult>}
   */
  isSameDay(userId: string, beginTime: number, endTime: number): Observable<BitResult> {
    return this.http.post<BitResult>(
      this.isSameDayUrl,
      JSON.stringify({ userId: userId, beginTime: beginTime, endTime: endTime }),
      this.httpOptions,
    );
  }

  /**
   * 根据时间类型获取每月/年请假次数统计
   * @author ludaxian
   * @date 2020-01-10
   * @param {string} dateType
   * @returns {Observable<BitResult>}
   */
  getUserLeaveCountEchartData(dateType: string): Observable<BitResult> {
    return this.http.get<BitResult>(`${this.getUserLeaveCountEchartDataUrl}/${dateType}`);
  }

  /**
   *取消申请
   * @author ludaxian
   * @date 2020-01-13
   * @param {LeaveInfo} leave
   * @returns {Observable<BitResult>}
   */
  cancelApply(leave: LeaveInfo): Observable<BitResult> {
    return this.http.post<BitResult>(this.cancelApplyUrl, JSON.stringify(leave), this.httpOptions);
  }

  /**
   *获取所有员工年假分析数据
   * @author ludaxian
   * @date 2020-01-16
   * @returns {Observable<BitResult>}
   */
  getAnnualLeave(userId: string): Observable<BitResult> {
    return this.http.get<BitResult>(`${this.getAnnualLeaveUrl}/${userId}`);
  }
}
