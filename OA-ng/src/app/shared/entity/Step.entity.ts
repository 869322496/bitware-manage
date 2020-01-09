export class Step {
  constructor(userName, status, time, title, icon, isMain, reason?) {
    this.userName = userName;
    this.status = status;
    this.time = time;
    this.title = title;
    this.icon = icon;
    this.isMain = isMain;
    this.reason = reason;
  }
  userName: string;
  status: string;
  time: Date;
  title: string;
  icon: string;
  isMain: boolean;
  reason?: string;
}
