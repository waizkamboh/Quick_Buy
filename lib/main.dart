import 'package:ecommerce_app/screen/auth_ui/login_screen.dart';
import 'package:ecommerce_app/screen/auth_ui/signup_screen.dart';
import 'package:ecommerce_app/screen/auth_ui/splash_screen.dart';
import 'package:ecommerce_app/screen/auth_ui/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'screen/user_panel/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}


