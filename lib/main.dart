import 'package:flutter/material.dart';
import 'package:like_minds_news_app/screens/news_feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.transparent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.transparent,
            tertiary: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: NewsFeed());
  }
}
