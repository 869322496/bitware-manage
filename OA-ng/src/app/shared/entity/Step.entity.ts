export class Step {
  constructor(userName, status, time, title, icon, isMain) {
    this.userName = userName;
    this.status = status;
    this.time = time;
    this.title = title;
    this.icon = icon;
  }
  userName: string;
  status: string;
  time: Date;
  title: string;
  icon: string;
  isMain: boolean;
}
