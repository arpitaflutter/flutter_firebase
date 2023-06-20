import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/fireHelper.dart';
import '../../home/model/home_model.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseHelper.firehelper.readbuy(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              QuerySnapshot? data = snapshot.data;
              List<TaskModel> PurchaseList = [];
              for (var x in data!.docs) {
                TaskModel t1 = TaskModel(
                    product: x['product'],
                    price: x['price'],
                    rate: x['rate'],
                    desc: x['desc'],
                    discount: x['discount'],
                    imgurl: x['imgurl'],
                    key: x.id);
                PurchaseList.add(t1);
              }
              return Padding(
                padding: const EdgeInsets.only(right: 3, top: 2),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        Text(
                          "My Orders",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade800),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/buy');
                          },
                          icon: Icon(Icons.add_shopping_cart_rounded),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: double.infinity,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.brown.shade100),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        "${PurchaseList[index].imgurl}"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${PurchaseList[index].product}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\$ ${PurchaseList[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 8,),
                                      Text("Order Placed",style: TextStyle(color: Colors.black54),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: PurchaseList.length,
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
