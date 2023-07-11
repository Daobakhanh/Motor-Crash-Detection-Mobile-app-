import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../themes/app_color.dart';
import '../../../../themes/app_text_style.dart';

class LongStadiumButton extends StatelessWidget {
  final double? width;
  final Color? color;
  final String? nameOfButton;
  final VoidCallback? onTap;
  const LongStadiumButton(
      {Key? key,
      required this.nameOfButton,
      required this.onTap,
      this.color,
      this.width})
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
          backgroundColor: color ?? AppColors.light,
          fixedSize: Size(width ?? 350, 44),
        ),
        child: Text(
          nameOfButton!,
          style: AppTextStyle.body15.copyWith(
            fontWeight: FontWeight.bold,
            color: color == AppColors.light || color == null
                ? AppTextColor.dark
                : AppTextColor.light,
          ),
        ),
      ),
    );
  }
}

class LongStadiumButtonIndicator extends StatelessWidget {
  final Color? color;
  // final String? nameOfButton;
  // final VoidCallback? onTap;
  const LongStadiumButtonIndicator({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.activeStateGreen,
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: color ?? AppColors.light,
            fixedSize: const Size(350, 44),
          ),
          child: const CupertinoActivityIndicator(
            color: AppColors.light,
          )),
    );
  }
}
