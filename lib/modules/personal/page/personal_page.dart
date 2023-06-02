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
      child: Scaffold(
        appBar: AppBar(
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
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        const SizedBox15H(),
                        deviceInfor != null
                            ? vehicleInfor != null
                                ? VehicleInforWidget(
                                    personalInfor: personalInfor,
                                    vehicleInfor: vehicleInfor,
                                  )
                                : _needToUpdateVehicleInfor()
                            : _linkDeviceToUserBtn(),

                        //Vehicle Owner
                        const SizedBox20H(),
                        PersonalInforWidget(personalInfor: personalInfor),
                        const SizedBox50H()
                      ],
                    ),

                    //Edit infor buttom
                    _editProfileButton(
                      widthScreen,
                      deviceInfor,
                      personalInfor,
                      vehicleInfor,
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
      ),
    );
  }

  final deviceMock = DeviceModel();

  Widget _linkDeviceToUserBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppTerm.vehicle,
            style: AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox10H(),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            'Don\'t have device infor, Please add device',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonalLinkToDevice(),
                  ));
            },
            icon: const Icon(Icons.link),
            label: const Text('Add vehicle here'),
          ),
        ),
        const SizedBox10H(),
        const Divider(
          color: AppColor.lightGray2,
          thickness: 1.5,
          height: 1.5,
        ),
      ],
    );
  }

  Widget _needToUpdateVehicleInfor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppTerm.vehicle,
            style: AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox10H(),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            'Added device, please update your vehicle information',
            maxLines: 2,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }

  Widget _editProfileButton(double widthScreen, DeviceModel? deviceInfor,
      UserModel personalInfor, VehicleDataModel? vehicleInfor) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: widthScreen - 30,
        child: ElevatedButton(
          onPressed: () {
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
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.lightGray1,
          ),
          child: const Text(
            AppTerm.edit,
            style: TextStyle(color: AppColor.dark),
          ),
        ),
      ),
    );
  }
}
