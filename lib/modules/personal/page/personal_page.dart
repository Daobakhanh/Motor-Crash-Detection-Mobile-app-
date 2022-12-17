import 'package:elderly_fall_stray_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:elderly_fall_stray_detection/themes/app_color.dart';
import 'package:elderly_fall_stray_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../common/app_term.dart';
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
              const SizedBox10H(),
              const Divider(
                thickness: 2,
                color: AppColor.lightGray,
                height: 5,
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
                title: MotorBikeInforTerm.brand,
                content: 'Honda',
              ),
              const ItemPersonalInforWidget(
                icon: Icons.color_lens,
                title: MotorBikeInforTerm.color,
                content: 'Black',
              ),
              const ItemPersonalInforWidget(
                icon: Icons.credit_card,
                title: MotorBikeInforTerm.numberPlates,
                content: '34C1-88999',
              ),
              const ItemPersonalInforDescriptionWidget(
                  icon: Icons.description,
                  title: MotorBikeInforTerm.description,
                  content: MotorBikeInforTerm.mockDes),
              const SizedBox10H(),
              const Divider(
                thickness: 2,
                color: AppColor.lightGray,
                height: 5,
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
                content: 'Dao Ba Khanh',
              ),
              const ItemPersonalInforWidget(
                icon: Icons.calendar_month,
                title: PersonalInforTerm.dob,
                content: '3/9/2000',
              ),
              const ItemPersonalInforWidget(
                icon: Icons.location_on,
                title: PersonalInforTerm.addr,
                content: '15 Ta Quang Buu, Bach Khoa',
              ),
              const ItemPersonalInforWidget(
                icon: Icons.phone,
                title: PersonalInforTerm.phoneNumber,
                content: '0357698570',
              ),
              const ItemPersonalInforWidget(
                icon: Icons.fingerprint,
                title: PersonalInforTerm.citizenId,
                content: '0302....0000',
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
                  backgroundColor: AppColor.lightGray,
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
