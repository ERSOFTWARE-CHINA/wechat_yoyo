// 获取当前时间MMddHHmmss
export function getLocalStamp() {
  let now = new Date()
  let month = getStr(now.getMonth()+1)
  let date = getStr(now.getDate())
  let hour = getStr(now.getHours())
  let minute = getStr(now.getMinutes())
  let sec = getStr(now.getSeconds())
  return month+date+hour+minute+sec
}

// YY-mm-dd hh:mm:ss
export function getDateTime() {
  let now = new Date()
  let year = now.getFullYear()
  let month = getStr(now.getMonth()+1)
  let date = getStr(now.getDate())
  let hour = getStr(now.getHours())
  let minute = getStr(now.getMinutes())
  let sec = getStr(now.getSeconds())
  return year+"-"+ month + "-" + date + " " + hour + ":" + minute + ":" + sec
}

// YY-mm-dd hh:mm:ss
export function getDate() {
  let now = new Date()
  let year = now.getFullYear()
  let month = getStr(now.getMonth()+1)
  let date = getStr(now.getDate())
  // let hour = getStr(now.getHours())
  // let minute = getStr(now.getMinutes())
  // let sec = getStr(now.getSeconds())
  return year+"-"+ month + "-" + date
}

export function getDateAfterThreeMonth() {
  let now = new Date()
  now.setDate(now.getDate() + 180);
  let year = now.getFullYear()
  let month = getStr(now.getMonth()+1)
  let date = getStr(now.getDate())

  return year+"-"+ month + "-" + date
}

export function getDateAfterDays(day) {
  let now = new Date()
  now.setDate(now.getDate() + day);
  let year = now.getFullYear()
  let month = getStr(now.getMonth()+1)
  let date = getStr(now.getDate())

  return year+"-"+ month + "-" + date
}


function getStr(i: number) {
    let s = i.toString()
    if (s.length == 2) return s
    if (s.length == 1) return "0" + s
    return "xx"
}
