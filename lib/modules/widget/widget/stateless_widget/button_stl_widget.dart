import 'package:flutter/material.dart';

import '../../../../themes/app_color.dart';
import '../../../../themes/app_text_style.dart';

class LongStadiumButton extends StatelessWidget {
  final Color? color;
  final String? nameOfButton;
  final VoidCallback? onTap;
  const LongStadiumButton(
      {Key? key, required this.nameOfButton, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.activeStateGreen,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onTap!,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: color ?? AppColor.light,
          fixedSize: const Size(350, 44),
        ),
        child: Text(
          nameOfButton!,
          style: AppTextStyle.body15.copyWith(
            fontWeight: FontWeight.bold,
            color: color == null ? AppTextColor.pink : AppTextColor.light,
          ),
        ),
      ),
    );
  }
}
