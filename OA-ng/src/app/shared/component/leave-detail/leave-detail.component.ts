import { Component, OnDestroy, OnInit, ChangeDetectorRef, Input, OnChanges, SimpleChanges } from '@angular/core';
import { Observable, Observer } from 'rxjs';
import { LeaveInfo } from '@shared/entity/LeaveInfo.entity';
import { UploadFile } from 'ng-zorro-antd';
import { BitService } from '@shared/service/Bit.service';

@Component({
  selector: 'leave-detail',
  templateUrl: './leave-detail.component.html',
  styleUrls: ['./leave-detail.component.less'],
})
export class LeaveDetailComponent implements OnInit, OnChanges {
  constructor(private bitService: BitService) {}
  @Input() leave: LeaveInfo = new LeaveInfo();
  imageList = []; //照片回显双绑文件集
  //照片放大回显参数
  showUploadList = {
    showPreviewIcon: true,
    showRemoveIcon: false,
    hidePreviewIconInNonImage: true,
  };
  /**
   * 回显回调
   */
  handlePreview = (file: UploadFile) => {
    this.previewImage = file.url || file.thumbUrl;
    this.previewVisible = true;
  };
  previewImage: string | undefined = '';
  previewVisible = false;
  ngOnInit(): void {
    this.imageEditBackView();
  }
  ngOnChanges(changes: SimpleChanges): void {
    this.imageEditBackView();
    /*  throw new Error("Method not implemented."); */
  }
  /**
   * 照片回显
   */
  imageEditBackView() {
    this.imageList = [];
    if (this.leave.img && JSON.parse(this.leave.img).length > 0) {
      JSON.parse(this.leave.img).forEach(item => {
        this.imageList = [
          ...this.imageList,
          {
            uid: this.bitService.uuid(),
            name: '巡检图片',
            status: 'done',
            trueUrl: item,
            url: `${BitService.ConstUtil.ApiUrl}\/upload${item.sourceFileUrl}`,
          },
        ];
      });
    }
  }
}
