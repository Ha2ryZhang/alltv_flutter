import 'package:alltv/http/dio_util.dart';
import 'package:alltv/model/live_room.dart';

class API {
  static Future<List<LiveRoom>> getRecommend(String cid) async {
    var json = await HttpManager.getInstance().get('/top/live/' + cid);
    List list=json["data"];
    List<LiveRoom> liveList=[];
    list.forEach((live){
      LiveRoom liveRoom = LiveRoom.fromJson(live);
      liveList.add(liveRoom);
    });
    return liveList;
  }
}
