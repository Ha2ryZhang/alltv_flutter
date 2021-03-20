import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/navigator_util.dart';
import 'package:alltv/route/routes.dart';
import 'package:alltv/utils/toast.dart';
import 'package:alltv/values/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isDark = false;
  String currentTheme;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentTheme = Provider.of<ThemeInfo>(context).themeColor;
    return Scaffold(
      appBar: new AppBar(
        title: Text("我", style: TextStyle(fontSize: 16.0)),
        centerTitle: true,
      ),
      body: buildColllumn(),
    );
  }

  //需设置ontap listtitle 才会有水波纹效果
  Widget buildColllumn() {
    return Column(
      children: <Widget>[
        buildUser(),
        ListTile(
          leading: Icon(
            Icons.textsms,
          ),
          title: Text(
            "消息中心",
          ),
          trailing: Text("待开发", style: TextStyle(color: Colors.grey)),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.visibility,
          ),
          title: Text(
            "历史记录",
          ),
          trailing: Text("待开发", style: TextStyle(color: Colors.grey)),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.turned_in,
          ),
          title: Text(
            "标签管理",
          ),
          trailing: Text("待开发", style: TextStyle(color: Colors.grey)),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.palette,
          ),
          title: Text(
            "主题切换",
          ),
          onTap: () {
            NavigatorUtil.jump(context, Routes.themeSetting);
          },
          trailing: Icon(Icons.brightness_1,
              color: ThemeColors.themeColor[currentTheme]["primaryColor"]),
        ),
        // ListTile(
        //     leading: Icon(
        //       Icons.brightness_medium,
        //     ),
        //     title: Text(
        //       "夜间模式",
        //     ),
        //     trailing: Switch(
        //         value: isDark,
        //         onChanged: (value) {
        //           setState(() {
        //             isDark = value;
        //           });
        //         }),
        //     onTap: () {
        //       setState(() {
        //         isDark = !isDark;
        //       });
        //       // Provider.of<ThemeInfo>(context,listen: false).setTheme("black");
        //     }),
        // ListTile(
        //   leading: Icon(
        //     Icons.assignment_late,
        //   ),
        //   title: Text(
        //     "意见反馈",
        //   ),
        //   onTap: () {},
        // ),
        ListTile(
          leading: Icon(
            Icons.settings,
          ),
          title: Text(
            "设置",
          ),
          trailing: Text("待开发", style: TextStyle(color: Colors.grey)),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.code,
          ),
          title: Text(
            "关于项目",
          ),
          trailing: Icon(Icons.navigate_next),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'alltv',
              applicationVersion: '1.2.0',
              applicationIcon: Image.asset(
                "assets/alltv.jpg",
                width: 80,
              ),
              applicationLegalese: 'by HarryZhang',
              children: <Widget>[
                Text(
                  '本项目是业余时间所写，随缘更新维护。',
                  style: TextStyle(fontSize: 13.5),
                ),
                Text(
                  '如果你觉得有帮助到你,那就麻烦点个Star吧！',
                  style: TextStyle(fontSize: 13.5),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 5),
                  leading: Image.asset(
                    "assets/Github.png",
                    width: 25,
                  ),
                  title: Text("Github"),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () async {
                    await launch("https://github.com/ha2ryzhang/alltv_flutter");
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 5),
                  leading: Image.asset(
                    "assets/juejin.png",
                    width: 25,
                  ),
                  title: Text("HarryZhang的博客"),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () async {
                    await launch(
                        "https://juejin.im/user/5ddb0cd4f265da7de03eca73");
                  },
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget buildUser() {
    return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListTile(
          onTap: () {
            showToast("努力开发中！");
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: Image.asset("assets/alltv.jpg").image,
          ),
          title: Text("alltv"),
          subtitle: Text("目前功能暂时较少，请见谅。"),
          trailing: Icon(Icons.navigate_next),
        ));
  }
}
