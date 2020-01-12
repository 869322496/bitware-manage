import { Pipe, PipeTransform } from '@angular/core';
import { BitService } from '@shared/service/Bit.service';

@Pipe({ name: 'isEmpty' })
export class IsEmptyPipe implements PipeTransform {
  constructor() {}
  /**
   * 在table，list,或其他不能显示null,"" 等场合转换为transstr
   * @param value 待转换值
   * @param transStr 转换值
   */
  transform(value, transStr?): string {
    if (
      'null' == value ||
      null == value ||
      undefined == value ||
      '' == value ||
      {} == value ||
      [] == value ||
      ' ' == value
    ) {
      return transStr ? transStr : BitService.ConstUtil.emptyStr;
    } else {
      return value;
    }
  }
}
