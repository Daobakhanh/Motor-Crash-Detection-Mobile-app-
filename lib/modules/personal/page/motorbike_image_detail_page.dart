import 'package:cached_network_image/cached_network_image.dart';
import 'package:elderly_fall_stray_detection/common/app_term.dart';
import 'package:elderly_fall_stray_detection/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MotorbikeImageDetail extends StatefulWidget {
  final String imageUrl;
  const MotorbikeImageDetail({required this.imageUrl, super.key});

  @override
  State<MotorbikeImageDetail> createState() => _MotorbikeImageDetailState();
}

class _MotorbikeImageDetailState extends State<MotorbikeImageDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthScreen = size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            // color: AppColor.activeStateBlue,
            // child: CachedNetworkImage(
            //   imageUrl: widget.imageUrl,
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // ),
            child: Image.asset(
              widget.imageUrl,
              // fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: widthScreen - 30,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.lightGray,
                ),
                child: const Text(
                  AppDataTerm.changeImage,
                  style: TextStyle(color: AppColor.dark),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: GestureDetector(
              child: const Icon(
                Icons.cancel,
                color: AppColor.grey,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
