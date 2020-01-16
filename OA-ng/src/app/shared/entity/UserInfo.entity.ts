import { ResourceInfo } from './ResourceInfo.entity';

export class UserInfo {
  userAccount: string;
  name: string;
  password: string;
  id: string;
  createDate: Date;
  lastLoginDate: Date;
  email: string;
  remark: string;
  isDelete: number;
  isEnable: number;
  orgId: string;
  tel: string;
  avatar: string;
  roleId: string;
  roleName: string;
  role: string;
  roleResource: ResourceInfo[];
  entryTime: Date;
}
