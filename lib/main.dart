// import 'package:alltv/config/global.dart';
// import 'package:alltv/pages/splash_page.dart';
// import 'package:alltv/provider/provider.dart';
// import 'package:alltv/route/Application.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() => Global.init().then((e) => runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider<CategoryList>.value(
//             value: Global.categories,
//           ),
//         ],
//         child: new MyApp()
//       ),
//     ));

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       onGenerateRoute: Application.router.generator,
//       title: 'All TV',
//       debugShowCheckedModeBanner: false,
//       home: SplashPage(),
//     );
//   }
// }

import 'package:alltv/widgets/video.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("widget.title"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: VideoScreen(
              url:
                  "http://tx2play1.douyucdn.cn/live/6867600r0JiZ7MIn.flv"),
        ),
      ),
    );
  }
}

