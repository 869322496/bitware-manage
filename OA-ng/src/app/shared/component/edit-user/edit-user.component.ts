import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { _Validators } from '@delon/util';
import { SysService } from '@shared/service/sys.service';
import { NzMessageService, NzModalRef } from 'ng-zorro-antd';
import { UserInfo } from '@shared/entity/UserInfo.entity';
import { BitService } from '@shared/service/Bit.service';

@Component({
  selector: 'app-edit-user',
  templateUrl: './edit-user.component.html',
  styleUrls: ['./edit-user.component.less'],
})
export class EditUserComponent implements OnInit {
  constructor(
    private fb: FormBuilder,
    private sysService: SysService,
    private msg: NzMessageService,
    private modalRef: NzModalRef,
    private bitService: BitService,
  ) {}
  userForm: FormGroup;
  submitting: boolean = false;
  ngOnInit() {
    this.userForm = this.fb.group({
      name: [
        null,
        [
          Validators.required,
          Validators.pattern(
            /^(?:[\u3400-\u4DB5\u4E00-\u9FEA\uFA0E\uFA0F\uFA11\uFA13\uFA14\uFA1F\uFA21\uFA23\uFA24\uFA27-\uFA29]|[\uD840-\uD868\uD86A-\uD86C\uD86F-\uD872\uD874-\uD879][\uDC00-\uDFFF]|\uD869[\uDC00-\uDED6\uDF00-\uDFFF]|\uD86D[\uDC00-\uDF34\uDF40-\uDFFF]|\uD86E[\uDC00-\uDC1D\uDC20-\uDFFF]|\uD873[\uDC00-\uDEA1\uDEB0-\uDFFF]|\uD87A[\uDC00-\uDFE0])+$/,
          ),
        ],
      ],
      userAccount: [null, Validators.required],
      email: [
        null,
        [
          Validators.pattern(
            /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
          ),
        ],
      ],
      tel: [null, Validators.pattern(/^(?:(?:\+|00)86)?1\d{10}$/)],
    });
  }

  /**
   *  新增用户
   *
   * @author ludaxian
   * @date 2020-01-12
   * @param {*} e
   */
  submit(e) {
    e['id'] = this.bitService.uuid();
    e['avatar'] = `http://www.bit-ware.com.cn/image/bitwarelog.png`;
    e['password'] = `111111`;
    this.sysService
      .insertUser(e)
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          this.msg.warning(res['errorMessage']);
          return;
        }
        this.msg.success('新增用户成功！');
        this.modalRef.destroy(true);
      });
  }
}
