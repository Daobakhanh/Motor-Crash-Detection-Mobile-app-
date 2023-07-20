import 'package:flutter/material.dart';
import 'package:motorbike_crash_theft_detection_system/lib.dart';

class ConnectionBatteryStatusWidget extends StatelessWidget {
  const ConnectionBatteryStatusWidget(
      {super.key, required this.isConnected, required this.batteryLevel});
  final bool isConnected;
  final double batteryLevel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: AppColors.grey.withOpacity(0.7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Connection status: $isConnected"),
          Text("Pin: $batteryLevel%"),
        ],
      ),
    );
  }
}
