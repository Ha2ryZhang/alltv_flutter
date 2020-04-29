import 'package:flutter/material.dart';

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ThirdBody(),
    );
  }
}

class ThirdBody extends StatelessWidget{
    @override 
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.yellow),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(image: new NetworkImage("https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3256100974,305075936&fm=26&gp=0.jpg",))
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                  child: Text("昵称："),
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              )
            ],
          )
        ],
      )
    );
     
      
  }
}