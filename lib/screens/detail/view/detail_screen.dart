import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/controller/home_controller.dart';
import 'package:flutter_firebase/utils/fireHelper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var args;
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    args = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 330,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.network("${args.imgurl}",
                        height: 28.h, width: 80.w),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "   ${args.product}",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  "New   ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700),
                )
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Row(
                children: [
                  Text(
                    "    \$ ${args.price}",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text("   Description:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 13,top: 5),
              child: Text("${args.desc}",style: TextStyle(color: Colors.grey.shade600)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.brown.shade200,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 40,
                        width: 157,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (controller.number > 0) {
                                  controller.number--;
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Obx(
                              () => Text(
                                "${controller.number.value}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            IconButton(
                              onPressed: () {
                                controller.number++;
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () async {

                          await FirebaseHelper.firehelper.cartProduct(
                            imgurl: args.imgurl,
                            discount: args.discount,
                            desc: args.desc,
                            rate: args.rate,
                            price: args.price,
                            product: args.product,
                            key: args.key
                          );
                              Get.toNamed('/cart');
                        },
                        child: Container(
                          height: 40,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add to cart",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                "assets/images/shopping.png",
                                width: 28,
                                height: 28,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "Discount:  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${args.discount} %",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: 57,
                      ),
                      Image.asset(
                        "assets/images/heart.png",
                        height: 25,
                        width: 25,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
