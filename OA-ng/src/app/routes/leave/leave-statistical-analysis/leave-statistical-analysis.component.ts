import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { NzMessageService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';

@Component({
  selector: 'leave-statistical-analysis',
  templateUrl: './leave-statistical-analysis.component.html',
  styleUrls: ['./leave-statistical-analysis.component.less'],
})
export class LeaveStatisticalAnalysisComponent implements OnInit {
  option = {
    title: {
      text: '本月请假情况',
      /*  subtext: 'Feature Sample: Gradient Color, Shadow, Click Zoom', */
    },
    xAxis: {
      type: 'category',
      data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    },
    yAxis: {
      type: 'value',
    },
    series: [
      {
        data: [120, 200, 150, 80, 70, 110, 130],
        type: 'bar',
      },
    ],
  };

  ngOnInit(): void {}

  constructor(fb: FormBuilder, private router: Router, public http: _HttpClient, public msg: NzMessageService) {}
}
