import { Component, OnDestroy, OnInit, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl, MaxLengthValidator } from '@angular/forms';
import { NzMessageService, UploadFile, UploadFilter } from 'ng-zorro-antd';
import { _HttpClient, SettingsService } from '@delon/theme';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { BitService } from '@shared/service/Bit.service';
import { pluck, debounceTime, switchMap, map, first } from 'rxjs/operators';
import { DictionaryItem } from '@shared/entity/DictionaryItem.entity';
import { SelectOption } from '@shared/entity/SelectOption.enetity';
import { LeaveService } from '../../../shared/service/leave.service';
import { Observable, Observer } from 'rxjs';
import { differenceInDays, startOfDay, addHours, endOfDay, addMinutes } from 'date-fns';

@Component({
  selector: 'leave-report',
  templateUrl: './leave-report.component.html',
  styleUrls: ['./leave-report.component.less'],
})
export class LeaveReportComponent implements OnInit {
  isHalfDay: boolean = false;
  radioValue: string = 'AM'; //上午下午
  constructor(
    private fb: FormBuilder,
    public msg: NzMessageService,
    private bitService: BitService,
    private settingService: SettingsService,
    private leaveService: LeaveService,
    private router: Router,
  ) {}
  /**
   * 异步校验名字是否重复
   */
  sameDayAsyncValidator = (control: FormControl): any => {
    return control.valueChanges.pipe(
      //防抖时间，单位毫秒
      debounceTime(1000),
      //调用服务，参数可写可不写，如果写的话变成如下形式
      switchMap(() => {
        if (!this.isHalfDay) {
          return this.leaveService
            .isSameDay(
              this.settingService.user.id,
              startOfDay(this.leaveForm.value['date'][0]).getTime(),
              endOfDay(this.leaveForm.value['date'][1]).getTime(),
            )
            .pipe(pluck('data'));
        } else {
          let beginTime;
          let endTime;
          if (this.leaveForm.value.dateType === 'AM') {
            //0:00-12:00
            beginTime = startOfDay(this.leaveForm.value.date).getTime();
            endTime = addHours(startOfDay(this.leaveForm.value.date), 12).getTime();
          } else {
            //12:01-23:59
            beginTime = addMinutes(addHours(startOfDay(this.leaveForm.value.date), 12), 1).getTime();
            endTime = endOfDay(this.leaveForm.value.date).getTime();
          }
          return this.leaveService.isSameDay(this.settingService.user.id, beginTime, endTime).pipe(pluck('data'));
        }
      }),
      //对返回值进行处理，null表示正确，对象表示错误
      map(data => {
        if (data['success'] && data['sameDayError']) {
          return {
            error: true,
            sameDayError: true,
            errorName: '日期存在重复',
          };
        } else {
          return null;
        }
      }),
      //每次验证的结果是唯一的，截断流
      first(),
    );
  };
  leaveForm: FormGroup;
  submitting = false;
  leaveTypeList: SelectOption[] = [];
  // ---照片---//
  imageList = []; // 照片回显双绑文件集
  // 照片放大回显参数
  showUploadList = {
    showPreviewIcon: true,
    showRemoveIcon: true,
    hidePreviewIconInNonImage: true,
  };
  /**
   * 图片过滤器
   */
  imagefilters: UploadFilter[] = [
    {
      name: 'type',
      fn: (nowChooseFiles: UploadFile[]) => {
        let errCode = '';
        const files = nowChooseFiles.filter(w => {
          if (
            !w.name.substring(w.name.length - 4).includes('png') &&
            !w.name.substring(w.name.length - 4).includes('jpg') &&
            !w.name.substring(w.name.length - 4).includes('jpeg') &&
            !w.name.substring(w.name.length - 4).includes('bmp')
          ) {
            errCode = 'formatVaild';
            return false;
          }
          if (
            this.imageList.some(historyFile => {
              return historyFile.name == w.name && historyFile;
            })
          ) {
            errCode = 'isSameVaild';
            return false;
          }
          return true;
        });
        switch (errCode) {
          case 'formatVaild':
            this.msg.warning('上传文件格式错误，仅支持png/jpeg/bmp/jpg格式！');
            break;
          case 'isSameVaild':
            this.msg.warning('上传文件中有相同文件,已为您取消上传！');
            break;
          case '':
            break;
          default:
            break;
        }
        return files;
      },
    },
    {
      name: 'async',
      fn: (nowChooseFiles: UploadFile[]) => {
        return new Observable((observer: Observer<UploadFile[]>) => {
          // doing
          observer.next(nowChooseFiles);
          observer.complete();
        });
      },
    },
  ];
  previewImage: string | undefined = '';
  previewVisible = false;
  /**
   * 回显回调
   */
  handlePreview = (file: UploadFile) => {
    this.previewImage = file.url || file.thumbUrl;
    this.previewVisible = true;
  };

  ngOnInit(): void {
    this.getLeaveType();
    this.leaveForm = this.fb.group({
      title: [null, [Validators.required]],
      date: [null, [Validators.required], this.sameDayAsyncValidator],
      leaveType: [null, [Validators.required]],
      reason: [null, [Validators.required]],
    });
  }

  /**
   *切换上下午
   *
   * @author ludaxian
   * @date 2020-01-09
   * @param {*} e
   */
  changeHalfDay(e) {
    /*   for (const i in this.leaveForm.controls) { */
    this.leaveForm.get('date').markAsDirty();
    this.leaveForm.get('date').updateValueAndValidity();

    /*  } */
    /*     const formvalue = this.leaveForm.value;
    if (e.dateType === 'AM') {
      //0:00-12:00
      this.leaveForm.patchValue({
        date: [startOfDay(formvalue.date), addHours(startOfDay(formvalue.date), 12)],
      });
    } else {
      this.leaveForm.patchValue({
        date: [addHours(startOfDay(formvalue.date), 12), endOfDay(formvalue.date)],
      });
    } */
  }
  /**
   * 切换时间类型
   */
  changeDateType() {
    this.isHalfDay = !this.isHalfDay;
    this.leaveForm.get('date').reset();
    if (this.isHalfDay) {
      this.leaveForm.addControl('dateType', this.fb.control('AM', [Validators.required]));
    } else {
      if (this.leaveForm.get('dateType')) this.leaveForm.removeControl('dateType');
    }
  }
  /**
   * 获取请假类别
   */
  getLeaveType() {
    this.bitService
      .getDictionary('LeaveType', 'all')
      .pipe(pluck('data'))
      .toPromise()
      .then((res: DictionaryItem[]) => (this.leaveTypeList = res.map(item => new SelectOption(item.code, item.name))));
  }

  submit(formvalue: any) {
    // console.log(leaveInfo);
    const leaveInfo: LeaveInfo = new LeaveInfo();
    leaveInfo.img = JSON.stringify(
      this.imageList.map(item => {
        return item.trueUrl;
      }),
    );
    leaveInfo.id = this.bitService.uuid();
    leaveInfo.orderNo = 'QJ' + new Date().getTime();
    leaveInfo.reason = formvalue.reason;
    leaveInfo.title = formvalue.title;
    leaveInfo.userId = this.settingService.user.id;
    if (this.isHalfDay) {
      //半天
      if (formvalue.dateType === 'AM') {
        //0:00-12:00
        leaveInfo.beginTime = startOfDay(formvalue.date).getTime();
        leaveInfo.endTime = addHours(startOfDay(formvalue.date), 12).getTime();
      } else {
        //12:01-23:59
        leaveInfo.beginTime = addMinutes(addHours(startOfDay(formvalue.date), 12), 1).getTime();
        leaveInfo.endTime = endOfDay(formvalue.date).getTime();
      }
      leaveInfo.dateType = formvalue.dateType;
    } else {
      //全天
      leaveInfo.dateType = 'ALL';
      leaveInfo.beginTime = startOfDay(formvalue.date[0]).getTime();
      leaveInfo.endTime = endOfDay(formvalue.date[1]).getTime();
    }
    leaveInfo.leaveType = formvalue.leaveType;
    this.submitting = true;
    this.leaveService
      .insertLeave(leaveInfo)
      .toPromise()
      .then(res => {
        if (res.hasErrors) {
          this.msg.error(res.errorMessage);
          return;
        }
        this.msg.success('上报请假成功！');
        this.router.navigateByUrl('leave/my-leave');
        this.leaveForm.reset();
      })
      .finally(() => {
        this.submitting = false;
      });
  }
  /**
   * 设置不可选时间
   */
  setDisabledDateRange = (current: Date) => {
    return differenceInDays(current, startOfDay(new Date())) < 0;
  };
  /**
   * 照片上传回调
   * @param data
   */
  imgHandleChange(data) {
    if (data.type === 'success') {
      data.file['trueUrl'] = data.file['response'].data; // 改单个文件并不能修改绑定fileList的值
      this.imageList = data.fileList.map(item => {
        return item.uid === data.file['uid'] ? data.file : item;
      });
    }
  }
}
