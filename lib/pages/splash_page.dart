import 'package:alltv/pages/first.dart';
import 'package:flutter/material.dart';
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
    await Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirstTab()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        // child: Image(image: AssetImage('assets/images/back.png'), fit: BoxFit.fill,),
        child: Center(child: Text("广告"),),
      );
    });
  }
}
