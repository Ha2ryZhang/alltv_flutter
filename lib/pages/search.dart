import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索",style:TextStyle(fontSize:16.0)),
        centerTitle: true,
      ),
      body: SearchBody(),
    );
  }
}
class SearchBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: TextField(
        decoration: InputDecoration(
         hintText: "房间号 昵称",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:Colors.blue,
              width: 2.0,
            ),
          ),
          prefixIcon: Icon(Icons.search),
        ),
        textInputAction: TextInputAction.go,
      )
    );
  }
}
// TODO 鬼知道怎么写