import 'package:ecommerce_app/utils/app_constant.dart';
import 'package:ecommerce_app/widget/banner_widget.dart';
import 'package:ecommerce_app/widget/custom_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppConstant.appTextColor
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarIconBrightness: Brightness.light,

        ),
        title: Text(AppConstant.appMainName, style: const TextStyle(
          color: AppConstant.appTextColor
        ),),
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 90.0,
            ),
            // banners
            const BannerWidget()
          ],
        ),
      ),
    );
  }
}
