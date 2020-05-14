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

// fijkplayer 但是我不喜欢这个鸡儿作者，高傲，估计还copy了 flutter_ijkplayer 的代码

// import 'package:alltv/widgets/video.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           // Here we take the value from the MyHomePage object that was created by
//           // the App.build method, and use it to set our appbar title.
//           title: Text("widget.title"),
//         ),
//         body: Center(
//           // Center is a layout widget. It takes a single child and positions it
//           // in the middle of the parent.
//           child: VideoScreen(
//               url:
//                   "https://bd.hls.huya.com/src/1447180114-1447180114-6215591261051551744-2135041736-10057-A-0-1_1200.m3u8"),
//         ),
//       ),
//     );
//   }
// }
