import 'package:alltv/config/global.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/Application.dart';
import 'package:alltv/values/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryList>.value(
            value: Global.categories,
          ),
          ChangeNotifierProvider<ThemeInfo>.value(
            value: Global.themeInfo,
          ),
        ],
        child: Consumer<ThemeInfo>(builder: (context, themeInfo, _) {
          return MyApp(themeInfo.themeColor);
        }),
      ),
    ));

class MyApp extends StatelessWidget {
  final String themeColor;

  MyApp(this.themeColor);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      title: 'All TV',
      theme: ThemeData(
          primaryColor: ThemeColors.themeColor[themeColor]["primaryColor"],
          primaryColorDark: ThemeColors.themeColor[themeColor]
              ["primaryColorDark"],
          accentColor: ThemeColors.themeColor[themeColor]["colorAccent"]),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
