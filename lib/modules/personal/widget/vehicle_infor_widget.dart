import 'package:flutter/material.dart';

import '../../../lib.dart';

class VehicleInforWidget extends StatelessWidget {
  const VehicleInforWidget(
      {super.key, required this.vehicleInfor, required this.personalInfor});
  final VehicleDataModel vehicleInfor;
  final UserModel personalInfor;
  final String imageUrl = 'assets/images/motorbike.jpeg';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: (() {
              debugPrint('Press see image detail');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MotorbikeImageDetail(
                    imageUrl: vehicleInfor.photoUrl ?? imageUrl,
                  ),
                ),
              );
            }),
            child: Image.asset(
              vehicleInfor.photoUrl ?? imageUrl,
              fit: BoxFit.contain,
              // width: 200,
              height: 100,
            ),
          ),
        ),
        const SizedBox25H(),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            AppTerm.vehicle,
            style: AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ItemPersonalInforWidget(
          icon: Icons.branding_watermark,
          title: VehicleInforTerm.brand,
          content: vehicleInfor.brand ?? VehicleInforDataMock.vehicleBrand,
        ),
        ItemPersonalInforWidget(
          icon: Icons.motorcycle,
          title: VehicleInforTerm.model,
          content: vehicleInfor.model ?? VehicleInforDataMock.vehicleModel,
        ),
        ItemPersonalInforWidget(
          icon: Icons.color_lens,
          title: VehicleInforTerm.color,
          content: vehicleInfor.color ?? VehicleInforDataMock.vehicleColor,
        ),
        ItemPersonalInforWidget(
          icon: Icons.credit_card,
          title: VehicleInforTerm.numberPlates,
          content: vehicleInfor.licensePlate ??
              VehicleInforDataMock.vehicleNumberPlates,
        ),
        const ItemPersonalInforDescriptionWidget(
            icon: Icons.description,
            title: VehicleInforTerm.description,
            content: VehicleInforDataMock.vehicleDescription),
        ItemPersonalInforWidget(
          icon: Icons.sos,
          title: PersonalInforTerm.sosNumber,
          content: personalInfor.sosNumbers![0],
        ),
        const SizedBox20H(),
      ],
    );
  }
}
