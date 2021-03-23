String convertCom(String? com) {
  switch (com) {
    case 'douyu':
      return "斗鱼";
    case 'bilibili':
      return "B站";
    case 'huya':
      return "虎牙";
    case 'egame':
      return"企鹅电竞";
    default:
      return "未知";
  }
}

String convertOnline(int online) {
  if (online >= 10000) {
    //dart 截断运算符
    return (online ~/ 10000).toString() + "万";
  }
  return online.toString();
}
