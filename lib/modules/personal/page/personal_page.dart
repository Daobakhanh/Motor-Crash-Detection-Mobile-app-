import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../lib.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final String imageUrl = 'assets/images/motorbike.jpeg';
  final _personalInforBloc = PersonalInforBloc();
  final deviceMock = DeviceModel();
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
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          bottom: const PreferredSize(
              preferredSize: Size.zero,
              child: Divider(
                height: 2,
              )),
          title: const Text(AppPageName.personal),
        ),
        endDrawer: const PersonalDrawerPage(),
        body: BlocBuilder<PersonalInforBloc, PersonalInforState>(
          bloc: _personalInforBloc,
          builder: (context, state) {
            final UserModel? personalInfor = state.user;
            final DeviceModel? deviceInfor = state.device;
            final personalInforError = state.error;
            if (personalInfor != null) {
              final VehicleDataModel? vehicleInfor = (deviceInfor == null)
                  ? DeviceModel().vehicle
                  //mock, remove ?? deviceMock.vehicle;
                  : state.device?.vehicle;

              return RefreshIndicator(
                onRefresh: () async {
                  _personalInforBloc.add(
                    PersonalBlocEvent(
                      event: PersonalInforBlocEventTitle.getPersonalInfor,
                    ),
                  );
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox15H(),
                        deviceInfor != null
                            ? vehicleInfor != null
                                ? VehicleInforWidget(
                                    personalInfor: personalInfor,
                                    vehicleInfor: vehicleInfor,
                                  )
                                : const NeedToUpdateVehicleInfor()
                            : const LinkDeviceToUserWidget(),

                        //Vehicle Owner
                        const SizedBox20H(),
                        PersonalInforWidget(personalInfor: personalInfor),
                        const SizedBox50H(),
                        _editProfileButton(
                          widthScreen,
                          deviceInfor,
                          personalInfor,
                          vehicleInfor,
                        ),
                        const SizedBox20H(),
                      ],
                    ),
                  ),
                ),

                //Edit infor buttom
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
      ),
    );
  }

  Widget _editProfileButton(double widthScreen, DeviceModel? deviceInfor,
      UserModel personalInfor, VehicleDataModel? vehicleInfor) {
    return LongStadiumButton(
      width: widthScreen,
      nameOfButton: AppTerm.edit,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalEditInforPage(
              deviceId: deviceInfor?.id ?? '0',
              personalInfor: personalInfor,
              vehicleInfor: vehicleInfor,
            ),
          ),
        );
      },
      color: AppColor.grey,
      // child: const Text(
      //   AppTerm.edit,
      //   style: TextStyle(color: AppColor.dark),
      // ),
    );
  }
}
