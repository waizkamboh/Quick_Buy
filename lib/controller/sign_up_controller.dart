import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethod(
      String userName,
      String userEmail,
      String userPhone,
      String userCIty,
      String userPassword,
      String userDeviceToken,
      ) async{
      try{
        EasyLoading.show(status: 'Please Wait');
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);

        // send email verification
        await userCredential.user!.sendEmailVerification();

        UserModel userModel = UserModel(
            uId: userCredential.user!.uid,
            username: userName,
            email: userEmail,
            phone: userPhone,
            userImg: '',
            userDeviceToken: userDeviceToken,
            country: '',
            userAddress: '',
            street: '',
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: userCIty);


        // add data into database
        _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());


        EasyLoading.dismiss();
        return userCredential;
      }
      on FirebaseAuthException catch(e){
        EasyLoading.dismiss();
        Get.snackbar(
            "Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondaryColor,
          colorText: AppConstant.appTextColor,
        );
      }


  }
}