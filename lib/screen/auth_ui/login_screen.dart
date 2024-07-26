import 'package:ecommerce_app/controller/get_user_data_controller.dart';
import 'package:ecommerce_app/controller/sign_in_controller.dart';
import 'package:ecommerce_app/screen/auth_ui/forget_password_screen.dart';
import 'package:ecommerce_app/screen/auth_ui/signup_screen.dart';
import 'package:ecommerce_app/screen/user_panel/main_screen.dart';
import 'package:ecommerce_app/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../admin_panel/admin_main_ui_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController signInController = Get.put(SignInController());
  GetUserDataController getUserDataController = Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: const Text(
              'Sign In',
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
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(() => TextFormField(
                      controller: userPassword,
                      obscureText: signInController.isPasswordVisible.value,
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              signInController.isPasswordVisible.toggle();
                            },
                              child: signInController.isPasswordVisible.value? const Icon(Icons.visibility_off): const Icon(Icons.visibility)
                          ),
                          contentPadding:
                          const EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),)
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Get.to(() => const ForgetPasswordScreen());
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                        color: AppConstant.appSecondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                      String password = userPassword.text.trim();

                      if(email.isEmpty || password.isEmpty){
                        Get.snackbar(
                          'Error', 'Please enter all details',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,);
                      }else{
                        UserCredential? userCredential = await signInController.signInMethod(email, password);

                        var userData = await getUserDataController.getUserData(userCredential!.user!.uid);

                        if(userCredential != null){
                          if(userCredential.user!.emailVerified){
                            if (userData[0]['isAdmin'] == true) {
                              Get.snackbar(
                                "Success Admin Login",
                                "login Successfully!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              Get.offAll(() => const AdminMainScreen());

                            }else{
                              Get.snackbar(
                                'Success', 'login successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              Get.offAll(() => const MainScreen());

                            }


                          }else{
                            Get.snackbar(
                              'Error', 'Please verify email before login',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.appTextColor,
                            );

                          }
                        }else{
                          Get.snackbar(
                            'Error', 'try again',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondaryColor,
                            colorText: AppConstant.appTextColor,);

                        }
                      }
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: AppConstant.appTextColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: AppConstant.appSecondaryColor),
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => const SignUpScreen()),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: AppConstant.appSecondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
