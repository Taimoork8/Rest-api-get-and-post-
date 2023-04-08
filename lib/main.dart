import 'package:flutter/material.dart';
import 'get_api/product_example.dart';
import 'get_api/example_two.dart';
import 'get_api/home_screen.dart';
import 'get_api/user_example.dart';
import 'get_api/user_example_withoutmodel.dart';
import 'post_api/signup.dart';
import 'post_api/image_postApi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const UploadImage(),
    );
  }
}
