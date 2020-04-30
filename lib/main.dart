import 'package:alltv/config/global.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/Application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => Global.init().then((e) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Category>.value(
            value: Global.category,
          ),
        ],
        child: new MyApp()
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      title: 'All TV',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}