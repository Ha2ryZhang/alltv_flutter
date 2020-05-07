import 'package:alltv/model/category.dart';
import 'package:alltv/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.adb,
                size: 160.0,
                color: Colors.white,
              ),
              Text(
                "Second Tab",
                style: TextStyle(color: Colors.white),
              ),
              FloatingActionButton(
                onPressed: (){
                  List categories = Provider.of<CategoryList>(context,listen: false).categories;
                  Category category=new Category(cid: "1008", name: "舞蹈");
                  categories.add(category);
                  Provider.of<CategoryList>(context).setCategories(categories);
                },
                child: Text("data"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
