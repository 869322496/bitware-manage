import { Injectable, Injector, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { DictionaryItem } from './entity/DictionaryItem.entity';

@Injectable({ providedIn: 'root' })
export class BitService {
  private getDictionaryUrl = 'OA/share/getDictionary';
  constructor(private http: HttpClient) {}

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
}
