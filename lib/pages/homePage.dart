import 'package:alltv/model/category.dart';
import 'package:alltv/pages/chanel.dart';
import 'package:alltv/pages/my_favorite.dart';
import 'package:alltv/pages/recommendation.dart';
import 'package:alltv/provider/categoryList.dart';
import 'package:alltv/provider/theme.dart';
import 'package:alltv/route/navigator_util.dart';
import 'package:alltv/route/routes.dart';
import 'package:alltv/values/theme_colors.dart';
import 'package:alltv/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllTVHome extends StatefulWidget {
  final int index;
  const AllTVHome({Key key, this.index}) : super(key: key);
  @override
  AllTVHomeState createState() => AllTVHomeState();
}

class AllTVHomeState extends State<AllTVHome>
    with SingleTickerProviderStateMixin {
  // int _currentIndex = 0;
  TabController _tabController;
  //推荐分类列表
  List<Category> _categoryList = [];
  int _currentIndex = 0;
  String title = "首页推荐";
  String currentTheme;
  bool _showBottom = true;
  List<Widget> _pageList = [];

  List<BottomNavigationBarItem> _barItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "喜欢"),
    BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "频道"),
    // BottomNavigationBarItem(icon: Icon(Icons.person),label:""),
  ];
  @override
  void initState() {
    super.initState();

    print(currentTheme);
    _categoryList =
        Provider.of<CategoryList>(context, listen: false).categories;

    _tabController = TabController(length: _categoryList.length, vsync: this);

    _pageList = [
      Recommendation(controller: _tabController),
      MyFavorite(),
      ChanelPage(),
      // MyPage()
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildTabBar() {
    List<Widget> widgets = [];
    _categoryList.forEach((c) {
      widgets.add(Tab(text: c.name));
    });

    return TabBar(
        tabs: widgets,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    currentTheme = Provider.of<ThemeInfo>(context).themeColor;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          elevation: 0,
          bottom: _showBottom ? buildTabBar() : null,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "搜索",
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            )
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: this._pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              switch (index) {
                case 0:
                  this.title = "首页推荐";
                  this._showBottom = true;
                  break;
                case 1:
                  this.title = "我的喜欢";
                  this._showBottom = false;
                  break;
                case 2:
                  this.title = "频道";
                  this._showBottom = false;
                  break;
              }
              this._currentIndex = index;
            });
          },
          currentIndex: this._currentIndex,
          items: _barItem,
          type: BottomNavigationBarType.fixed,
        ),
        drawer: Drawer(
          child:
              ListView(padding: EdgeInsets.zero, children: buildDrawerItems()),
        ));
  }

  List<Widget> buildDrawerItems() {
    return <Widget>[
      UserAccountsDrawerHeader(
        margin: EdgeInsets.zero,
        accountName: Text(
          "All TV",
        ),
        accountEmail: Text(
          "happy every day",
        ),
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
            applicationVersion: '1.3.0',
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
                  "assets/github-logo.png",
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
    ];
  }
}
