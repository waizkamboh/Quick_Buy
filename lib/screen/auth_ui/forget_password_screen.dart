import 'package:ecommerce_app/controller/forget_password_controller.dart';
import 'package:ecommerce_app/controller/sign_in_controller.dart';
import 'package:ecommerce_app/screen/auth_ui/signup_screen.dart';
import 'package:ecommerce_app/screen/user_panel/main_screen.dart';
import 'package:ecommerce_app/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: const Text(
              'Forget Password',
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),
          body: Column(
            children: [
              isKeyboardVisible
                  ? const SizedBox.shrink()
                  : Column(
                children: [
                  Lottie.asset('assets/images/splash-icon.json'),
                ],
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          contentPadding:
                          const EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )),
              SizedBox(
                height: Get.height / 20,
              ),
              Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () async{
                      String email = userEmail.text.trim();

                      if(email.isEmpty){
                        Get.snackbar(
                          'Error', 'Please enter all details',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,);
                      }else{
                        forgetPasswordController.forgetPasswordMethod(email);
                      }
                    },
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(color: AppConstant.appTextColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
