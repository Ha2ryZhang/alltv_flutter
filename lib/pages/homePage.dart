import 'package:flutter/material.dart';
import 'package:alltv/pages/first.dart';
import 'package:alltv/pages/second.dart';
import 'package:alltv/pages/third.dart';
class AllTVHome extends StatefulWidget {
  @override
  AllTVHomeState createState() => AllTVHomeState();
}

class AllTVHomeState extends State<AllTVHome> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TabBarView(
        children: <Widget>[FirstTab(), SecondTab(), ThirdTab()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
          ],
          controller: controller,
        ),
      ),
    );
  }
}