import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/controller/home_controller.dart';
import 'package:flutter_firebase/screens/home/model/home_model.dart';
import 'package:get/get.dart';

import '../../../utils/fireHelper.dart';
import '../../../utils/notification_service.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  bool isSignin = false;
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    FirebaseHelper.firehelper.checkUser();
    controller.userData.value = FirebaseHelper.firehelper.userDetails();
    NotificationService.notificationService.initMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown.shade100,
        body: StreamBuilder(
          stream: FirebaseHelper.firehelper.readData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<TaskModel> taskList = [];
              QuerySnapshot? snapData = snapshot.data;
              for (var x in snapData!.docs) {
                Map? data = x.data() as Map;
                print(data);
                String? product = data['product'];
                String? discount = data['discount'];
                String? rate = data['rate'];
                String? desc = data['desc'];
                String? price = data['price'];
                String? imgurl = data['imgurl'];

                TaskModel t1 = TaskModel(
                    price: price,
                    imgurl: imgurl,
                    discount: discount,
                    key: x.id,
                    desc: desc,
                    product: product,
                    rate: rate);

                taskList.add(t1);
              }
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/menu.png",
                            height: 20, width: 20),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/cart');
                          },
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hi, Helen",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "What's your today's shopping?",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "assets/images/shopping.png",
                          height: 33,
                          width: 33,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2 / 3),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  TaskModel t1 = TaskModel(
                                      product: taskList[index].product,
                                      price: taskList[index].price,
                                      rate: taskList[index].rate,
                                      desc: taskList[index].desc,
                                      discount: taskList[index].discount,
                                      imgurl: taskList[index].imgurl);
                                  Get.toNamed('/detail', arguments: t1);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 180,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.network(
                                      "${taskList[index].imgurl}"),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "     ${taskList[index].product}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "New   ",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "      \$ ${taskList[index].price}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        },
                        itemCount: taskList.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        drawer: Drawer(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "Your Profile",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage("${controller.userData['img']}"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("${controller.userData['name']}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${controller.userData['email']}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/cart');
                    },
                    child: Text(
                      "Cart Products",
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 1,width: 170,color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/buy');
                    },
                      child: Text("Ordered Products",style: TextStyle(fontSize: 17),)),
                  Spacer(),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: () {
                      FirebaseHelper.firehelper.logOut();
                      Get.offAndToNamed('/home');
                    },
                      child: Text("Sign out",style: TextStyle(fontSize: 17),)),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
