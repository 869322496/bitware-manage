import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { SysService } from '@shared/service/sys.service';
import { NzMessageService, NzModalRef } from 'ng-zorro-antd';
import { BitService } from '@shared/service/Bit.service';

@Component({
  selector: 'app-edit-role',
  templateUrl: './edit-role.component.html',
  styleUrls: ['./edit-role.component.less'],
})
export class EditRoleComponent implements OnInit {
  @Input() orderNo: number;
  constructor(
    private fb: FormBuilder,
    private sysService: SysService,
    private msg: NzMessageService,
    private modalRef: NzModalRef,
    private bitService: BitService,
  ) {}

  roleForm: FormGroup;
  submitting: boolean = false;
  ngOnInit() {
    this.roleForm = this.fb.group({
      name: [null, [Validators.required]],
      code: [null, Validators.required],
      remark: [null],
      /*  tel: [null, Validators.pattern(/^(?:(?:\+|00)86)?1\d{10}$/)], */
    });
  }

  /**
   *
   *  新增编辑角色
   * @author ludaxian
   * @date 2020-01-12
   * @param {*} e
   */
  submit(e) {
    e['id'] = this.bitService.uuid();
    e['orderNo'] = this.orderNo;
    this.sysService
      .insertRole([e])
      .toPromise()
      .then(res => {
        if (res['hasErrors']) {
          this.msg.warning(res['errorMessage']);
          return;
        }
        this.msg.success('新增角色成功！');
        this.modalRef.destroy(true);
      });
  }
}
