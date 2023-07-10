import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/tabbar_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const TwitterTabbarView(),
      theme: ThemeData.light().copyWith(
        appBarTheme:
            AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
        textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        tabBarTheme: const TabBarTheme(
            labelColor: CupertinoColors.activeBlue,
            unselectedLabelColor: CupertinoColors.inactiveGray),
      ),
    );
  }
}
