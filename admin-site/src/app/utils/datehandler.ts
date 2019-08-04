// 获取当前日期 "2019-08-04"
export function getNowFormatDate() {
  const date = new Date();
  const seperator1 = '-';
  const year = date.getFullYear();
  let month: any = date.getMonth() + 1;
  let strDate: any = date.getDate();
  if (month >= 1 && month <= 9) {
    month = '0' + month.toString();
  }
  if (strDate >= 0 && strDate <= 9) {
    strDate = '0' + strDate.toString();
  }
  return year + seperator1 + month + seperator1 + strDate;
}

// 获取当前时间
export function getNowFormatTime() {
  const date = new Date();
  const seperator1 = ':';
  let h: any = date.getHours();
  let m: any = date.getMinutes();
  let s: any = date.getSeconds();
  if (h >= 1 && h <= 9) {
    h = '0' + h.toString();
  }
  if (m >= 0 && m <= 9) {
    m = '0' + m.toString();
  }
  if (s >= 0 && s <= 9) {
    s = '0' + s.toString();
  }
  return h + seperator1 + m + seperator1 + s;
}
