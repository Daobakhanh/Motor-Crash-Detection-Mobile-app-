import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';

class GetLocationWidget extends StatelessWidget {
  const GetLocationWidget({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // color: AppColor.activeStateBlue,
        margin: const EdgeInsets.only(bottom: 25),
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            backgroundColor: AppColors.lightBlue.withOpacity(0.5),
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Icons.location_searching,
            size: 60,
            color: AppColors.dark,
          ),
          onPressed: () {
            onPressed.call();
          },
        ),
      ),
    );
  }
}
