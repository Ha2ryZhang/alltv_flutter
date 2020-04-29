import 'package:alltv/route/Application.dart';
import 'package:alltv/route/routes.dart';
import 'package:alltv/pages/homePage.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(MaterialApp(
      onGenerateRoute: Application.router.generator,
      title: "All TV",
      home: AllTVHome()));
}