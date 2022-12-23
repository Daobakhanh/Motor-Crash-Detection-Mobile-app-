import 'package:motorbike_crash_detection/data/mock/app_infor_mock.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:motorbike_crash_detection/themes/app_color.dart';
import 'package:motorbike_crash_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../data/term/app_term.dart';
import '../widget/personal_infor_widget.dart';
import 'motorbike_image_detail_page.dart';
import 'personal_drawer_page.dart';
import 'personal_edit_page.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final String imageUrl = 'assets/images/motorbike.jpeg';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthScreen = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppRouteName.personal),
      ),
      endDrawer: const PersonalDrawerPage(),
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox15H(),
              GestureDetector(
                onTap: (() {
                  debugPrint('Press see image detail');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MotorbikeImageDetail(
                        imageUrl: imageUrl,
                      ),
                    ),
                  );
                }),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                  // width: 200,
                  height: 100,
                ),
              ),
              const SizedBox15H(),
              const Divider(
                thickness: 1.5,
                color: AppColor.lightGray2,
                height: 1.5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Vehicle',
                  style:
                      AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const ItemPersonalInforWidget(
                icon: Icons.branding_watermark,
                title: VehicleInforTerm.brand,
                content: VehicleInforDataMock.vehicleBrand,
              ),
              const ItemPersonalInforWidget(
                icon: Icons.color_lens,
                title: VehicleInforTerm.color,
                content: VehicleInforDataMock.vehicleColor,
              ),
              const ItemPersonalInforWidget(
                icon: Icons.credit_card,
                title: VehicleInforTerm.numberPlates,
                content: VehicleInforDataMock.vehicleNumberPlates,
              ),
              const ItemPersonalInforDescriptionWidget(
                  icon: Icons.description,
                  title: VehicleInforTerm.description,
                  content: VehicleInforDataMock.vehicleDescription),
              const SizedBox10H(),
              const Divider(
                color: AppColor.lightGray2,
                thickness: 1.5,
                height: 1.5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Owner',
                  style:
                      AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const ItemPersonalInforWidget(
                icon: Icons.person,
                title: PersonalInforTerm.name,
                content: PersonalInforDataMock.name,
              ),
              const ItemPersonalInforWidget(
                icon: Icons.calendar_month,
                title: PersonalInforTerm.dob,
                content: PersonalInforDataMock.dob,
              ),
              const ItemPersonalInforWidget(
                icon: Icons.location_on,
                title: PersonalInforTerm.addr,
                content: PersonalInforDataMock.addr,
              ),
              const ItemPersonalInforWidget(
                icon: Icons.phone,
                title: PersonalInforTerm.phoneNumber,
                content: PersonalInforDataMock.phoneNumber,
              ),
              const ItemPersonalInforWidget(
                icon: Icons.fingerprint,
                title: PersonalInforTerm.citizenId,
                content: PersonalInforDataMock.citizenId,
              ),
              const SizedBox50H()
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: widthScreen - 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalEditInforPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.lightGray1,
                ),
                child: const Text(
                  AppTerm.edit,
                  style: TextStyle(color: AppColor.dark),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
