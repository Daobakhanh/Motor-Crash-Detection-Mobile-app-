import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget(
      {super.key, required this.onPressed, required this.isLoadingOfWarning});
  final Function() onPressed;
  final bool isLoadingOfWarning;
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
            backgroundColor: AppColors.grey.withOpacity(0.5),
            shape: const CircleBorder(),
          ),
          child: isLoadingOfWarning
              ? const CupertinoActivityIndicator(
                  color: AppColors.light,
                )
              : const Icon(
                  Icons.warning_sharp,
                  size: 60,
                  color: AppColors.activeStateYellow,
                ),
          onPressed: () {
            onPressed.call();
          },
        ),
      ),
    );
  }
}
