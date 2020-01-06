import { LeaveAudit } from './LeaveAudit.enetity';

export class LeaveInfo {
  id: string;
  userId: string;
  leaveType: string;
  title: string;
  beginTime: Date;
  endTime: Date;
  reason: string;
  orderNo: string;
  leaveTypeName: string;
  userName: string;
  createTime: Date;
  status: number;
  auditorName: string;
  reviewerName: string;
  leaveProcess: LeaveAudit[];
}
