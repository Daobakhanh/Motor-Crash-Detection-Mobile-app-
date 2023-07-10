import 'package:flutter/material.dart';

import '../../../lib.dart';

class NeedToUpdateVehicleInfor extends StatelessWidget {
  const NeedToUpdateVehicleInfor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            AppTerm.vehicle,
            style: AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox10H(),
        const SizedBox(
          // padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Added device, please update your vehicle information',
            maxLines: 2,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
