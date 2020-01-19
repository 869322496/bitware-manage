import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { DictionaryItem } from '../entity/DictionaryItem.entity';
import { NzMessageService } from 'ng-zorro-antd';
import { PlatformLocation } from '@angular/common';
import { Tree } from '@shared/entity/Tree.entity';

@Injectable({ providedIn: 'root' })
export class BitService {
  constructor(private http: HttpClient, private msg: NzMessageService, private planform: PlatformLocation) {
    if (!`${planform['location']['host']}`.includes('localhost'))
      BitService.ConstUtil.ApiUrl = `http://${planform['location']['host']}`;
  }
  public static ConstUtil = {
    // 常量池
    noimg: '../assets/imgs/addphoto.png',
    emptyStr: '-',
    ApiUrl: 'http://localhost:8080',
    LEAVEAGREESTATUS: 10,
    LEAVEREFUSESTATUS: 9,
  };
  private getDictionaryUrl = 'OA/share/getDictionary';

  public static IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ['Android', 'iPhone', 'SymbianOS', 'Windows Phone', 'iPad', 'iPod'];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
      if (userAgentInfo.indexOf(Agents[v]) > 0) {
        flag = false;
        break;
      }
    }
    return flag;
  }

  /**
   * 获取字典项
   * @param dicCode all获取全部
   * @param dicItemCode all获取全部
   */
  getDictionary(dicCode: string, dicItemCode: string): Observable<DictionaryItem[]> {
    return this.http.get<DictionaryItem[]>(this.getDictionaryUrl + '/' + dicCode + '/' + dicItemCode);
  }
  /**
   * 生成uuid
   */
  uuid() {
    const s = [];
    const hexDigits = '0123456789abcdef';
    for (let i = 0; i < 36; i++) {
      s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = '4'; // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = '-';
    return s.join('');
  }
  /**
   * 生成loading
   * @param time
   */
  createLoading(time: number, title: string, callback?) {
    this.msg.loading('1');
  }

  /**
   * 树结构数组扁平化
   */
  formatTreeToArr(tree: Tree[]) {
    let arr: Array<Tree> = [];
    const format = tree => {
      if (tree.length === 0) return;
      tree.forEach(item => {
        arr = [...arr, item];
        if (item['children'].length > 0) {
          format(item['children']);
        }
      });
      return arr;
    };
    return format(tree);
  }
}
