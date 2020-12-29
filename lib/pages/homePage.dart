import 'package:alltv/pages/chanel.dart';
import 'package:alltv/pages/my.dart';
import 'package:alltv/pages/my_favorite.dart';
import 'package:alltv/pages/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AllTVHome extends StatefulWidget {
  final int index;
  const AllTVHome({Key key, this.index}) : super(key: key);
  @override
  AllTVHomeState createState() => AllTVHomeState();
}

class AllTVHomeState extends State<AllTVHome>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> _pageList = [
    Recommendation(),
    MyFavorite(),
    ChanelPage(),
    MyPage()
  ];
  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      setState(() {
        this._currentIndex = widget.index;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  double gap = 10;
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: this._pageList,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (int index) {
      //     setState(() {
      //       this._currentIndex = index;
      //     });
      //   },
      //   currentIndex: this._currentIndex,
      //   items: _barItem,
      //   type: BottomNavigationBarType.fixed,
      // ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 60,
                      color: Colors.black.withOpacity(.4),
                      offset: Offset(0, 25))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
              child: GNav(
                  curve: Curves.easeOutExpo,
                  duration: Duration(milliseconds: 900),
                  tabs: [
                    GButton(
                      gap: gap,
                      iconActiveColor: Colors.blue,
                      iconColor: Colors.black,
                      textColor: Colors.blue,
                      backgroundColor: Colors.blue.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: Icons.home,
                      // textStyle: t.textStyle,
                      text: 'Home',
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: Colors.pink,
                      iconColor: Colors.black,
                      textColor: Colors.pink,
                      backgroundColor: Colors.pink.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: Icons.favorite,

// textStyle: t.textStyle,
                      text: 'Likes',
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: Colors.amber[600],
                      iconColor: Colors.black,
                      textColor: Colors.amber[600],
                      backgroundColor: Colors.amber[600].withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: Icons.live_tv,
// textStyle: t.textStyle,
                      text: 'Channel',
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: Colors.teal,
                      iconColor: Colors.black,
                      textColor: Colors.teal,
                      backgroundColor: Colors.teal.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: Icons.people,
                      leading: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                              "https://sooxt98.space/content/images/size/w100/2019/01/profile.png")),
// textStyle: t.textStyle,
                      text: 'Mine',
                    )
                  ],
                  selectedIndex: this._currentIndex,
                  onTabChange: (index) {
                    // _debouncer.run(() {

                    print(index);
                    setState(() {
                      this._currentIndex = index;
                      // badge = badge + 1;
                    });
                    // });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
