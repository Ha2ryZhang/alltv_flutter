class BiliBiliHostServerConfig {
  double? refreshRowFactor;
  int? refreshRate;
  int? maxDelay;
  int? port;
  String? host;
  List<HostServerList>? hostServerList;
  List<ServerList>? serverList;
  String? token;

  BiliBiliHostServerConfig(
      {this.refreshRowFactor,
      this.refreshRate,
      this.maxDelay,
      this.port,
      this.host,
      this.hostServerList,
      this.serverList,
      this.token});

  BiliBiliHostServerConfig.fromJson(Map<String, dynamic> json) {
    refreshRowFactor = json['refresh_row_factor'];
    refreshRate = json['refresh_rate'];
    maxDelay = json['max_delay'];
    port = json['port'];
    host = json['host'];
    if (json['host_server_list'] != null) {
      hostServerList = [];
      json['host_server_list'].forEach((v) {
        hostServerList!.add(new HostServerList.fromJson(v));
      });
    }
    if (json['server_list'] != null) {
      serverList = [];
      json['server_list'].forEach((v) {
        serverList!.add(new ServerList.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh_row_factor'] = this.refreshRowFactor;
    data['refresh_rate'] = this.refreshRate;
    data['max_delay'] = this.maxDelay;
    data['port'] = this.port;
    data['host'] = this.host;
    if (this.hostServerList != null) {
      data['host_server_list'] =
          this.hostServerList!.map((v) => v.toJson()).toList();
    }
    if (this.serverList != null) {
      data['server_list'] = this.serverList!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }
}

class HostServerList {
  String? host;
  int? port;
  int? wssPort;
  int? wsPort;

  HostServerList({this.host, this.port, this.wssPort, this.wsPort});

  HostServerList.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    port = json['port'];
    wssPort = json['wss_port'];
    wsPort = json['ws_port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host'] = this.host;
    data['port'] = this.port;
    data['wss_port'] = this.wssPort;
    data['ws_port'] = this.wsPort;
    return data;
  }
}

class ServerList {
  String? host;
  int? port;

  ServerList({this.host, this.port});

  ServerList.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host'] = this.host;
    data['port'] = this.port;
    return data;
  }
}
