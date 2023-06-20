import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/fireHelper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown.shade100,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Lottie.asset("assets/json/signup.json",
                      height: 300, width: 300)),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    color: Color(0xff363F60),
                    fontSize: 45,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please login or signup using this app",
                style: TextStyle(color: Color(0xff363F60), fontSize: 17),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/signup');
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff363F60)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Sign UP",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff363F60),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/signin');
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Color(0xff363F60),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Sign IN",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffDDF1FA),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Container(
                    height: 1,
                    width: 80,
                    color: Color(0xff363F60),
                  ),
                  Text(
                    "   or via social media   ",
                    style: TextStyle(color: Color(0xff363F60), fontSize: 17),
                  ),
                  Container(
                    height: 1,
                    width: 80,
                    color: Color(0xff363F60),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      String msg =
                          await FirebaseHelper.firehelper.sighInWithGoogle();
                      Get.snackbar("Success", "successfully login");

                      if (msg == "Success") {
                        Get.offAndToNamed('/app');
                      }
                    },
                    child: Text("Sign In with google",
                        style: TextStyle(fontSize: 17, color: Color(0xff363F60))),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/images/google.png",
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
