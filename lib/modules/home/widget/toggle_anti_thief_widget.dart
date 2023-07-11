import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';

class ToggleAntiThiefWidget extends StatelessWidget {
  const ToggleAntiThiefWidget(
      {super.key, required this.onPressed, required this.isOnAntiThief});
  final Function() onPressed;
  final bool isOnAntiThief;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: isOnAntiThief
              ? AppColors.safety.withOpacity(0.7)
              : AppColors.grey.withOpacity(0.7),
          shape: const CircleBorder(),
        ),
        child: Icon(
          isOnAntiThief == true ? Icons.lock : Icons.lock_open,
          size: 40,
          color: AppColors.dark,
        ),
        onPressed: () {
          onPressed.call();
        },
      ),
    );
  }
}
