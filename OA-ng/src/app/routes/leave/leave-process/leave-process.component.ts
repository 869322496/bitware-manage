import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';

@Component({
  selector: 'leave-process',
  templateUrl: './leave-process.component.html',
  styleUrls: ['./leave-process.component.less'],
})
export class LeaveProcessComponent implements OnInit {
  constructor(
    private fb: FormBuilder,
    private cdr: ChangeDetectorRef,
    private router: Router,
    public http: _HttpClient,
    public msg: NzMessageService,
  ) {}
  leaveForm: FormGroup;
  submitting = false;

  ngOnInit(): void {
    /*  this.leaveForm = this.fb.group({
      title: [null, [Validators.required]],
      date: [null, [Validators.required]],
      leaveType: [null, [Validators.required]],
      reason: [null, [Validators.required]],
    }); */
  }

  submit() {
    this.submitting = true;
    setTimeout(() => {
      this.submitting = false;
      this.msg.success(`提交成功`);
      this.cdr.detectChanges();
    }, 1000);
  }
}
