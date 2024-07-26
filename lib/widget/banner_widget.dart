import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final BannerController _bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CarouselSlider(
        items: _bannerController.bannersUrls
            .map(
              (imageUrls) => ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: imageUrls,
              fit: BoxFit.cover,
              width: Get.width - 10,
              placeholder: (context, url) => const ColoredBox(
                color: Colors.white,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ).toList(),
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          autoPlay: false,
          aspectRatio: 2.5,
          viewportFraction: 1,
        ),
      );
    });
  }
}