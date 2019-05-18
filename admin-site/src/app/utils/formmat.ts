import { HttpParams } from '@angular/common/http';

// 删除为空或空字符串的参数，并格式化匹配后台的排序参数值
export function formmat(obj) {
  for (var key in obj) {
    if ((obj[key] === null) || (obj[key] === "")) {
      delete obj[key]
    }
    if (obj[key] == "ascend") obj[key] = "asc";
    if (obj[key] == "descend") obj[key] = "desc"
  }
  return obj
}

// 格式化get请求参数，可以直接传给http.get方法
export function getOptionWithParams(obj) {
  return { params: formmat(obj) }
}
