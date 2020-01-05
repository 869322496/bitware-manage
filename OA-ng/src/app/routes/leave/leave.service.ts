import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { InvokeResult } from '@shared/entity/InvokeResult.entity';

@Injectable({ providedIn: 'root' })
export class LeaveService {
  private insertLeaveUrl = 'OA/leave/insertLeave';
  private getLeaveByIdUrl = 'OA/leave/getLeaveById';
  private getLeaveByUserIdUrl = 'OA/leave/getLeaveByUserId';
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
  insertLeave(leave: LeaveInfo): Observable<InvokeResult> {
    return this.http.post<InvokeResult>(this.insertLeaveUrl, leave, this.httpOptions);
  }

  /**
   * 获取请假信息
   * @param id
   */
  getLeaveById(id?: string): Observable<InvokeResult> {
    return this.http.get<InvokeResult>(this.getLeaveByIdUrl + '/' + (id ? id : 'all'));
  }

  /**
   * 获取请假信息
   * @param userId
   */
  getLeaveByUserId(userId?: string): Observable<InvokeResult> {
    return this.http.get<InvokeResult>(this.getLeaveByUserIdUrl + '/' + (userId ? userId : 'all'));
  }
}
