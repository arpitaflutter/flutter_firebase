import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/fireHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user;
  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3), () async {
      user=await FirebaseHelper.firehelper.firebaseAuth.currentUser;
      if (user == null) {
        Get.offAndToNamed('/home');
      } else {
        Get.offAndToNamed('/app');
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown.shade100,
        body: Center(
          child: Lottie.asset("assets/json/logo.json"),
        ),
      ),
    );
  }
}
