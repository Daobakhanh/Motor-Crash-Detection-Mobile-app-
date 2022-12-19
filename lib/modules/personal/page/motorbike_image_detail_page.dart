import 'package:elderly_fall_stray_detection/common/term/app_term.dart';
import 'package:elderly_fall_stray_detection/themes/app_color.dart';
import 'package:flutter/material.dart';

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
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: widthScreen - 30,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.lightGray,
                  ),
                  child: const Text(
                    AppTerm.changeImage,
                    style: TextStyle(color: AppColor.dark),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            right: 15,
            child: GestureDetector(
              child: const Icon(
                Icons.cancel,
                color: AppColor.grey,
                size: 35,
              ),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Press close detail Image');
              },
            ),
          ),
        ],
      ),
    );
  }
}
