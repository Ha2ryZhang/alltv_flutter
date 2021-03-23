class VersionInfo {
  int? clientVersionCode;
  String? clientVersionName;
  String? serverVersion;
  String? lastUpdateTime;
  String? newVersionUrl;

  VersionInfo(
      {this.clientVersionCode,
      this.clientVersionName,
      this.serverVersion,
      this.lastUpdateTime,
      this.newVersionUrl});

  VersionInfo.fromJson(Map<String, dynamic> json) {
    clientVersionCode = json['clientVersionCode'];
    clientVersionName = json['clientVersionName'];
    serverVersion = json['serverVersion'];
    lastUpdateTime = json['lastUpdateTime'];
    newVersionUrl = json['newVersionUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientVersionCode'] = this.clientVersionCode;
    data['clientVersionName'] = this.clientVersionName;
    data['serverVersion'] = this.serverVersion;
    data['lastUpdateTime'] = this.lastUpdateTime;
    data['newVersionUrl'] = this.newVersionUrl;
    return data;
  }
}
