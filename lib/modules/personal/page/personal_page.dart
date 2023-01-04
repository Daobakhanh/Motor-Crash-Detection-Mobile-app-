import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_crash_detection/data/mock/app_infor_mock.dart';
import 'package:motorbike_crash_detection/modules/personal/bloc/personal_bloc_event.dart';
import 'package:motorbike_crash_detection/modules/personal/bloc/personal_infor_bloc.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:motorbike_crash_detection/themes/app_color.dart';
import 'package:motorbike_crash_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../data/term/app_term.dart';
import '../widget/personal_infor_widget.dart';
import 'personal_motorbike_image_detail_page.dart';
import 'personal_drawer_page.dart';
import 'personal_edit_page.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final String imageUrl = 'assets/images/motorbike.jpeg';
  final _personalInforBloc = PersonalInforBloc();

  @override
  void initState() {
    super.initState();
    _personalInforBloc.add(
      PersonalBlocEvent(
        event: PersonalInforBlocEventTitle.getPersonalInfor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthScreen = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppPageName.personal),
      ),
      endDrawer: const PersonalDrawerPage(),
      body: BlocBuilder<PersonalInforBloc, PersonalInforState>(
        bloc: _personalInforBloc,
        builder: (context, state) {
          final personalInfor = state.user;
          final deviceInfor = state.device;
          final personalInforError = state.error;
          if (personalInfor != null && deviceInfor != null) {
            final vehicleInfor = state.device!.vehicle;

            return RefreshIndicator(
              onRefresh: () async {
                _personalInforBloc.add(
                  PersonalBlocEvent(
                    event: PersonalInforBlocEventTitle.getPersonalInfor,
                  ),
                );
              },
              child: Stack(
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
                                imageUrl: vehicleInfor.photoUrl ?? imageUrl,
                              ),
                            ),
                          );
                        }),
                        child: Image.asset(
                          vehicleInfor!.photoUrl ?? imageUrl,
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
                          AppTerm.vehicle,
                          style: AppTextStyle.body17
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.branding_watermark,
                        title: VehicleInforTerm.brand,
                        content: vehicleInfor.brand ??
                            VehicleInforDataMock.vehicleBrand,
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.motorcycle,
                        title: VehicleInforTerm.model,
                        content: vehicleInfor.model ??
                            VehicleInforDataMock.vehicleModel,
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.color_lens,
                        title: VehicleInforTerm.color,
                        content: vehicleInfor.color ??
                            VehicleInforDataMock.vehicleColor,
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

                      const SizedBox10H(),
                      const Divider(
                        color: AppColor.lightGray2,
                        thickness: 1.5,
                        height: 1.5,
                      ),

                      //Vehicle Owner
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppTerm.owner,
                          style: AppTextStyle.body17
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.person,
                        title: PersonalInforTerm.name,
                        content:
                            personalInfor.name ?? PersonalInforDataMock.name,
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.calendar_month,
                        title: PersonalInforTerm.dob,
                        content: personalInfor.dateOfBirth ??
                            PersonalInforDataMock.dob,
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.location_on,
                        title: PersonalInforTerm.addr,
                        content:
                            personalInfor.address ?? PersonalInforDataMock.addr,
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.phone,
                        title: PersonalInforTerm.phoneNumber,
                        content: personalInfor.phoneNumber ??
                            PersonalInforDataMock.phoneNumber,
                      ),
                      ItemPersonalInforWidget(
                        icon: Icons.fingerprint,
                        title: PersonalInforTerm.citizenId,
                        content: personalInfor.citizenNumber ??
                            PersonalInforDataMock.citizenId,
                      ),
                      const SizedBox50H()
                    ],
                  ),

                  //Edit infor buttom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: widthScreen - 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalEditInforPage(
                                deviceId: deviceInfor.id ?? '',
                                personalInfor: personalInfor,
                                vehicleInfor: vehicleInfor,
                              ),
                            ),
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
          if (personalInforError != null) {
            return Center(
              child: Text(
                personalInforError.toString(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
