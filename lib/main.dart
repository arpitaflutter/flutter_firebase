import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/appPage/view/app_screen.dart';
import 'package:flutter_firebase/screens/cart/view/cart_screen.dart';
import 'package:flutter_firebase/screens/detail/view/detail_screen.dart';
import 'package:flutter_firebase/screens/home/view/home_screen.dart';
import 'package:flutter_firebase/screens/purchase/view/purchase_screen.dart';
import 'package:flutter_firebase/screens/signIn/view/SignIn_screen.dart';
import 'package:flutter_firebase/screens/signUp/view/SignUp_screen.dart';
import 'package:flutter_firebase/screens/splash/view/splash_screen.dart';
import 'package:flutter_firebase/utils/notification_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.notificationService.initNotification();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(name: '/', page: () => SplashScreen()),
            GetPage(name: '/home', page: () => HomeScreen()),
            GetPage(name: '/signin', page: () => SignInScreen()),
            GetPage(name: '/signup', page: () => SignUpScreen()),
            GetPage(name: '/app', page: () => AppScreen()),
            GetPage(name: '/detail', page: () => DetailScreen()),
            GetPage(name: '/cart', page: () => CartScreen()),
            GetPage(name: '/buy', page: () => PurchaseScreen()),
          ],
        );
      },
    ),
  );
}
