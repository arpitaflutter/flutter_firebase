import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/model/home_model.dart';
import 'package:flutter_firebase/utils/fireHelper.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseHelper.firehelper.cartRead(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              QuerySnapshot? data = snapshot.data;
              List<TaskModel> cartList = [];
              for (var x in data!.docs) {
                TaskModel t1 = TaskModel(
                    product: x['product'],
                    price: x['price'],
                    rate: x['rate'],
                    desc: x['desc'],
                    discount: x['discount'],
                    imgurl: x['imgurl'],
                    key: x.id);
                cartList.add(t1);
              }
              return Padding(
                padding: const EdgeInsets.only(right: 3,top: 2),
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
                          "My Cart",
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
                        ),                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 190,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.brown.shade100),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 160,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        "${cartList[index].imgurl}"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, left: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${cartList[index].product}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\$ ${cartList[index].price}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        height: 60,
                                        width: 150,
                                        child: Text(
                                          "${cartList[index].desc}",
                                          style:
                                              TextStyle(color: Colors.black54),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: ()  {

                                               FirebaseHelper.firehelper.addbuy(
                                                product: cartList[index].product,
                                                price: cartList[index].price,
                                                rate: cartList[index].rate,
                                                desc: cartList[index].desc,
                                                discount: cartList[index].discount,
                                                imgurl: cartList[index].imgurl,
                                              );
                                              Get.toNamed('/buy');
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Buy",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              FirebaseHelper.firehelper
                                                  .deleteData(cartList[index].key!);

                                              Get.snackbar(
                                                  "Delete data successfully", "");
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 73,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: cartList.length,
                      ),
                    ),
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
