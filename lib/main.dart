//import 'package:apitutorial/selfmademodel.dart';
//import 'package:apitutorial/usermodelexample3/usermodelex3.dart';
//import 'package:apitutorial/withoutmodelex4/withoutmodel.dart';
//import 'package:apitutorial/postsignup/postsignup.dart';
import 'package:apitutorial/postuploadimg/postuploadimg.dart';
import 'package:flutter/material.dart';
//import 'package:apitutorial/home.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Postuploadimg(),
    );
  }
}