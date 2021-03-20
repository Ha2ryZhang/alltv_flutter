import 'package:alltv/provider/provider.dart';
import 'package:alltv/utils/utils.dart';
import 'package:alltv/values/storages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSetting extends StatefulWidget {
  @override
  _ThemeSettingState createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  String currentTheme;
  @override
  void initState() {
    currentTheme = Provider.of<ThemeInfo>(context, listen: false).themeColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("主题风格")),
      body: buildThemeList(),
    );
  }

  Widget buildCurrentUseButton(String theme) {
    if (currentTheme == theme) {
      return Icon(Icons.check_circle);
    } else {
      return null;
    }
  }

  Widget buildThemeList() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.brightness_1, color: Color(0xff4caf50)),
          title: Text("原谅绿"),
          trailing: buildCurrentUseButton('green'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('green');
            setState(() {
              currentTheme = 'green';
            });
            StorageUtil().setString(THEME_INFO, "green");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.brightness_1,
            color: Color(0xffF44336),
          ),
          title: Text("姨妈红"),
          trailing: buildCurrentUseButton('red'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('red');
            setState(() {
              currentTheme = 'red';
            });
            StorageUtil().setString(THEME_INFO, "red");
          },
        ),
        ListTile(
          leading: Icon(Icons.brightness_1, color: Color(0xff2196F3)),
          title: Text("知乎蓝"),
          trailing: buildCurrentUseButton('blue'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('blue');
            setState(() {
              currentTheme = 'blue';
            });
            StorageUtil().setString(THEME_INFO, "blue");
          },
        ),
        ListTile(
          leading: Icon(Icons.brightness_1, color: Color(0xffdb5a6b)),
          title: Text("哔哩粉"),
          trailing: buildCurrentUseButton('pink'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('pink');
            setState(() {
              currentTheme = 'pink';
            });
            StorageUtil().setString(THEME_INFO, "pink");
          },
        ),
        ListTile(
          leading: Icon(Icons.brightness_1, color: Color(0xff673AB7)),
          title: Text("基佬紫"),
          trailing: buildCurrentUseButton('purple'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('purple');
            setState(() {
              currentTheme = 'purple';
            });
            StorageUtil().setString(THEME_INFO, "purple");
          },
        ),
        ListTile(
          leading: Icon(Icons.brightness_1, color: Color(0xff9E9E9E)),
          title: Text("低调灰"),
          trailing: buildCurrentUseButton('grey'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('grey');
            setState(() {
              currentTheme = 'grey';
            });
            StorageUtil().setString(THEME_INFO, "grey");
          },
        ),
        ListTile(
          leading: Icon(Icons.brightness_1, color: Color(0xff333333)),
          title: Text("高端黑"),
          trailing: buildCurrentUseButton('black'),
          onTap: () {
            Provider.of<ThemeInfo>(context, listen: false).setTheme('black');
            setState(() {
              currentTheme = 'black';
            });
            StorageUtil().setString(THEME_INFO, "black");
          },
        ),
      ],
    );
  }
}
