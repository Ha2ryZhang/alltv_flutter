import 'package:alltv/pages/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:alltv/pages/second.dart';
import 'package:alltv/pages/third.dart';

class AllTVHome extends StatefulWidget {
  @override
  AllTVHomeState createState() => AllTVHomeState();
}

class AllTVHomeState extends State<AllTVHome>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> _pageList = [
    Recommendation(),
    SecondTab(),
    SecondTab(),
    ThirdTab(),
  ];

  List<BottomNavigationBarItem> _barItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Container()),
     BottomNavigationBarItem(icon: Icon(Icons.search), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Container()),
  ];
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
    return Scaffold(
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        currentIndex: this._currentIndex,
        items: _barItem,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Widget buildBottomBar(){
  //   return BottomNavigationBar(items: null)
  // }
}
