import 'package:api_integration/home_screen.dart';
import 'package:api_integration/photos_api_test.dart';
import 'package:api_integration/user_api_test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: const HomeScreen(),
      home:const PhotosApiTest(),
      //home:const UserApiTest(),
    );
  }
}
