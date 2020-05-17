class LiveRoom {
  String roomId;
  String com;
  String cateId;
  String roomThumb;
  String cateName;
  String roomName;
  int roomStatus;
  String startTime;
  String ownerName;
  String avatar;
  int online;
  String realUrl;

  LiveRoom(
      {this.roomId,
      this.com,
      this.cateId,
      this.roomThumb,
      this.cateName,
      this.roomName,
      this.roomStatus,
      this.startTime,
      this.ownerName,
      this.avatar,
      this.online,
      this.realUrl});

  LiveRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    com = json['com'];
    cateId = json['cateId'];
    roomThumb = json['roomThumb'];
    cateName = json['cateName'];
    roomName = json['roomName'];
    roomStatus = json['roomStatus'];
    startTime = json['startTime'];
    ownerName = json['ownerName'];
    avatar = json['avatar'];
    online = json['online'];
    realUrl = json['realUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['com'] = this.com;
    data['cateId'] = this.cateId;
    data['roomThumb'] = this.roomThumb;
    data['cateName'] = this.cateName;
    data['roomName'] = this.roomName;
    data['roomStatus'] = this.roomStatus;
    data['startTime'] = this.startTime;
    data['ownerName'] = this.ownerName;
    data['avatar'] = this.avatar;
    data['online'] = this.online;
    data['realUrl'] = this.realUrl;
    return data;
  }
}
