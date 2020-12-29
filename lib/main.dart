import 'package:alltv/config/global.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/Application.dart';
import 'package:alltv/route/routes.dart';
import 'package:alltv/values/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

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
      home: QuickActionsManager(),
    );
  }
}

class QuickActionsManager extends StatefulWidget {
  final Widget child;
  QuickActionsManager({Key key, this.child}) : super(key: key);

  @override
  _QuickActionsManagerState createState() => _QuickActionsManagerState();
}

class _QuickActionsManagerState extends State<QuickActionsManager> {
  bool isFromAction = false;
  @override
  void initState() {
    super.initState();
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      switch (shortcutType) {
        case 'likes':
          setState(() {
            isFromAction = true;
          });
          Application.router.navigateTo(context, Routes.home + '?index=1',
              clearStack: true, rootNavigator: true);
          break;
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'user', localizedTitle: '我的', icon: 'user'),
      const ShortcutItem(
        type: 'likes',
        localizedTitle: '我的关注',
        icon: 'likes',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    print('isFromAction' + isFromAction.toString());
    return SplashPage();
  }
}
