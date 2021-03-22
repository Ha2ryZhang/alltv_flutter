import 'package:alltv/route/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 闪屏页
class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startHome();
  }

  startHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      NavigatorUtil.goHomePage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: Lottie.asset("assets/lottie/splash.json"),
              ),
              Text(
                "今天你的操作下饭了吗？",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "All TV",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
