import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firehelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUP({required email, required password}) async {
    String msg = "";
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");

    return msg;
  }

  Future<String?> signIN({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");

    return msg;
  }

  bool checkUser() {
    User? user;
    return user != null;
  }

  Future<String> sighInWithGoogle() async {
    String msg = "";
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication auth = await googleSignInAccount!.authentication;

    AuthCredential crd = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    return await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();

    GoogleSignIn().signOut();
  }

  Map<String, String?> userDetails() {
    User? user = firebaseAuth.currentUser;

    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;

    return {"email": email, "img": img, "name": name};
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readData() {
    return firestore.collection("product").snapshots();
  }

  Future<String?> cartProduct(
      {product, price, desc, discount, rate, imgurl, key}) async {
    String uid = getUid();

    String? msg;
    return await firestore
        .collection("userdata")
        .doc(uid)
        .collection("cart")
        .add({
          "product": product,
          "price": price,
          "desc": desc,
          "rate": rate,
          "discount": discount,
          "imgurl": imgurl
        })
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartRead() {
    String uid = getUid();
    return firestore
        .collection("userdata")
        .doc(uid)
        .collection("cart")
        .snapshots();
  }

  String getUid() {
    User? user = firebaseAuth.currentUser;

    String? uid = user!.uid;
    return uid;
  }

  Future<void> deleteData(String key) async {
    String uid = getUid();
    await firestore
        .collection("userdata")
        .doc(uid)
        .collection("cart")
        .doc(key)
        .delete();
  }

  Future<void> buyDelete(String key)
  async {
    await firestore.collection("buy").doc(key).delete();
  }

  // Future<String?> buyProductAdmin({product, price, desc, discount, rate, imgurl,key})
  // async {
  //   String? msg;
  //   String uid = getUid();
  //   await firestore.collection("buy").add({
  //     "product":product,
  //     "price":price,
  //     "desc":desc,
  //     "discount":discount,
  //     "rate":rate,
  //     "imgurl":imgurl
  //   }).then((value) => msg = "Success").catchError((e) => "$e");
  //   return msg;
  // }//seller

  // Stream<QuerySnapshot<Map<String, dynamic>>> readBuyAdmin()
  // {
  //   return firestore.collection("buy").snapshots();
  // }

  Future<String?> buyProductUser(
      {product, price, desc, discount, rate, imgurl}) async {
    String? msg;
    String uid=getUid();
    return await firestore
        .collection("userdata")
        .doc("$uid")
        .collection("buy")
        .add({
          "product": product,
          "price": price,
          "desc": desc,
          "discount": discount,
          "rate": rate,
          "imgurl": imgurl
        })
        .then((value) => msg = "Success")
        .catchError((e) => "$e");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readBuyUser() {
    String uid = getUid();
    return firestore
        .collection("userdata")
        .doc(uid)
        .collection("buy")
        .snapshots();
  } //user

  Stream<QuerySnapshot<Map<String, dynamic>>> readbuy()
  {
    return firestore.collection("buy").snapshots();
  }

  void addbuy({product, price, desc, discount, rate, imgurl}) {
    firestore.collection('buy').add({
      "product": product,
      "price": price,
      "desc": desc,
      "discount": discount,
      "rate": rate,
      "imgurl": imgurl
    });
  }
}
