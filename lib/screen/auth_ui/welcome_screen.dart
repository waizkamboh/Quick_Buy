import 'package:ecommerce_app/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        title: const Text(
          'Welcome to my app',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Lottie.asset('assets/images/splash-icon.json'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
                'Happy Shopping',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),
          SizedBox(
            height: Get.height / 12,
          ),
          Material(
            child: Container(
              width: Get.width / 1.2,
              height: Get.height / 12,
              decoration: BoxDecoration(
                color: AppConstant.appSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton.icon(
                icon: Image.asset(
                    'assets/images/final-google-logo.png',
                  width: Get.width / 12,
                  height: Get.height / 12,
                ),
                  onPressed: (){},
                  label: const Text(
                      'Sign in with google',
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height / 50,
          ),
          Material(
            child: Container(
              width: Get.width / 1.2,
              height: Get.height / 12,
              decoration: BoxDecoration(
                color: AppConstant.appSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton.icon(
                icon: const Icon(Icons.email, color: AppConstant.appTextColor,),
                  onPressed: (){},
                  label: const Text(
                      'Sign in with email',
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
