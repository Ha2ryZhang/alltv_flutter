import 'package:alltv/http/dio_util.dart';
import 'package:alltv/model/live_room.dart';
import 'package:alltv/utils/toast.dart';
import 'package:dio/dio.dart';

class API {
  /// 首页推荐
  static Future<List<LiveRoom>> getRecommendAll(String cid, int pageNum) async {
    var json = await HttpManager.getInstance()
        .get('/top/live/' + cid, params: {"pageNum": pageNum});
    List list = json["data"];
    List<LiveRoom> liveList = [];
    list.forEach((live) {
      LiveRoom liveRoom = LiveRoom.fromJson(live);
      liveList.add(liveRoom);
    });
    return liveList;
  }

  /// 平台推荐
  static Future<List<LiveRoom>> getRecommendByCom(
      String com, int pageNum) async {
    var json = await HttpManager.getInstance().get('/' + com + '/top_rooms',
        params: {"pageNum": pageNum, "pageSize": 15});
    List list = json["data"];
    List<LiveRoom> liveList = [];
    list.forEach((live) {
      LiveRoom liveRoom = LiveRoom.fromJson(live);
      liveList.add(liveRoom);
    });
    return liveList;
  }

  static Future<String> getLiveUrl(String roomId, String com) async {
    switch (com) {
      case "bilibili":
        return getBiLiveUrl(roomId);
      default:
        var json = await HttpManager.getInstance()
            .get('/' + com + '/real_url/' + roomId);
        var data = json['data'];
        return data['realUrl'];
    }
  }

  ///由于bilibili 风控对linux ，获取不到直播链，改为手动获取
  static Future<String> getBiLiveUrl(String roomId) async {
    String url =
        "https://api.live.bilibili.com/room/v1/Room/playUrl?cid=$roomId&platform=h5&otype=json&quality=3";
    Dio dio = Dio();
    try {
      Response res = await dio.get(url,
          options: Options(
            receiveTimeout: 5000,
            sendTimeout: 5000,
          ));

      if (res.data["data"]["durl"] != null) {
        List<String> list = [];
        for (Map<String, dynamic> i in res.data["data"]["durl"]) {
          if (i != null && i["url"] != null) {
            list.add(i["url"]);
          }
        }
        String url = list[0];
        return url;
      }
      return null;
    } catch (e) {
      print(e.toString());
      showToast("bilibili未知错误");
      return null;
    }
  }
}
