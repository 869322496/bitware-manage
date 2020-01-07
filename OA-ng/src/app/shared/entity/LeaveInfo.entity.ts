import { LeaveAudit } from './LeaveAudit.enetity';

export class LeaveInfo {
  id: string;
  userId: string;
  leaveType: string;
  title: string;
  beginTime: Date | number;
  endTime: Date | number;
  reason: string;
  orderNo: string;
  leaveTypeName: string;
  userName: string;
  createTime: Date | number;
  status: number;
  auditorName: string;
  reviewerName: string;
  leaveProcess: LeaveAudit[];
  img: string;
  role: string;
  dateType: string;
  statusName: string;
}
