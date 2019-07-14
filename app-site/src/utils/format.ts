
export function deleteAttr(obj){
  for(var key in obj) {
    if((obj[key] === '')||(obj[key]==null)) {
      delete obj[key]
    }
  }
  return obj
}