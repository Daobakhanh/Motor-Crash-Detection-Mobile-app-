import 'package:motorbike_crash_detection/data/mock/app_infor_mock.dart';
import 'package:motorbike_crash_detection/data/term/app_term.dart';
import 'package:motorbike_crash_detection/model/user/user_model.dart';
import 'package:motorbike_crash_detection/modules/device/model/vehicle_model/vehicle_model.dart';
import 'package:motorbike_crash_detection/modules/personal/page/personal_page.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../navigation/pages/app_navigation.dart';
import '../bloc/personal_infor_bloc.dart';
import '../bloc/personal_update_bloc.dart';

class PersonalEditInforPage extends StatefulWidget {
  final UserModel? personalInfor;
  final VehicleDataModel? vehicleInfor;
  final String deviceId;
  const PersonalEditInforPage(
      {super.key,
      this.personalInfor,
      this.vehicleInfor,
      required this.deviceId});

  @override
  State<PersonalEditInforPage> createState() => _PersonalEditInforPageState();
}

class _PersonalEditInforPageState extends State<PersonalEditInforPage> {
  int maxLine = 5;
  bool isDone = false;
  final _personalInforBloc = PersonalInforBloc();

  UserModel get personalInfor => widget.personalInfor!;
  VehicleDataModel get vehicleInfor => widget.vehicleInfor!;
  String get deviceId => widget.deviceId;

  String vehicleColor = '';
  String vehicleBrand = '';
  String vehicleModel = '';
  String vehicleNumberPlate = '';

  String ownerAddress = '';
  String ownerName = '';
  String ownerDoB = '';
  String ownerPhoneNumber = '';
  String ownerCitizenID = '';

  late TextEditingController _controllerTextVehicleColor;
  late TextEditingController _controllerTextVehicleBrand;
  late TextEditingController _controllerTextVehicleModel;
  late TextEditingController _controllerTextVehicleDescription;
  late TextEditingController _controllerTextVehicleNumberPlate;

  late TextEditingController _controllerTextOwnerAddress;
  late TextEditingController _controllerTextOwnerName;
  late TextEditingController _controllerTextOwnerDoB;
  late TextEditingController _controllerTextOwnerPhoneNumber;
  late TextEditingController _controllerTextOwnerCitizenID;

  @override
  void dispose() {
    super.dispose();

    _controllerTextVehicleColor.dispose();
    _controllerTextVehicleDescription.dispose();
    _controllerTextVehicleBrand.dispose();
    _controllerTextVehicleNumberPlate.dispose();
    _controllerTextVehicleModel.dispose();

    _controllerTextOwnerAddress.dispose();
    _controllerTextOwnerName.dispose();
    _controllerTextOwnerDoB.dispose();
    _controllerTextOwnerPhoneNumber.dispose();
    _controllerTextOwnerCitizenID.dispose();
  }

  @override
  void initState() {
    super.initState();

    vehicleColor = vehicleInfor.color ?? VehicleInforDataMock.vehicleColor;
    vehicleBrand = vehicleInfor.brand ?? VehicleInforDataMock.vehicleBrand;
    vehicleModel = vehicleInfor.model ?? VehicleInforDataMock.vehicleModel;
    vehicleNumberPlate =
        vehicleInfor.licensePlate ?? VehicleInforDataMock.vehicleNumberPlates;

    ownerAddress = personalInfor.address ?? PersonalInforDataMock.addr;
    ownerName = personalInfor.name ?? PersonalInforDataMock.name;
    ownerDoB = personalInfor.dateOfBirth ?? PersonalInforDataMock.dob;
    ownerPhoneNumber =
        personalInfor.phoneNumber ?? PersonalInforDataMock.phoneNumber;
    ownerCitizenID =
        personalInfor.citizenNumber ?? PersonalInforDataMock.citizenId;

    _controllerTextVehicleBrand = TextEditingController(
        text: vehicleInfor.brand ?? VehicleInforDataMock.vehicleBrand);
    _controllerTextVehicleModel = TextEditingController(
        text: vehicleInfor.model ?? VehicleInforDataMock.vehicleModel);
    _controllerTextVehicleColor = TextEditingController(
        text: vehicleInfor.color ?? VehicleInforDataMock.vehicleColor);
    _controllerTextVehicleDescription =
        TextEditingController(text: VehicleInforDataMock.vehicleDescription);
    _controllerTextVehicleNumberPlate = TextEditingController(
        text: vehicleInfor.licensePlate ??
            VehicleInforDataMock.vehicleNumberPlates);

    _controllerTextOwnerAddress = TextEditingController(
        text: personalInfor.address ?? PersonalInforDataMock.addr);
    _controllerTextOwnerCitizenID = TextEditingController(
        text: personalInfor.citizenNumber ?? PersonalInforDataMock.citizenId);
    _controllerTextOwnerDoB = TextEditingController(
        text: personalInfor.dateOfBirth ?? PersonalInforDataMock.dob);
    _controllerTextOwnerName = TextEditingController(
        text: personalInfor.name ?? PersonalInforDataMock.name);
    _controllerTextOwnerPhoneNumber = TextEditingController(
        text: personalInfor.phoneNumber ?? PersonalInforDataMock.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppTerm.edit),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _handleUpdatePersonalProfile();
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  isDone = !isDone;
                });
                Future.delayed(const Duration(seconds: 1), () async {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const PersonalPage()),
                      (Route<dynamic> route) => false);
                });
              },
              child: isDone
                  ? const CupertinoActivityIndicator(
                      color: AppColor.light,
                    )
                  : Text(
                      'Done',
                      style: AppTextStyle.body17.copyWith(
                        color: AppColor.activeStateBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Infor: vehicle
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppTerm.vehicle,
                  style:
                      AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox10H(),

              //vehicle brand editting
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextVehicleBrand,
                      onChanged: (String contentValue) {
                        vehicleBrand = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: VehicleInforTerm.brand,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextVehicleBrand.clear();
                            setState(() {
                              maxLine = 1;
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //vehicle model editting
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextVehicleModel,
                      onChanged: (String contentValue) {
                        vehicleModel = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: VehicleInforTerm.model,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextVehicleModel.clear();
                            setState(() {
                              maxLine = 1;
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //vehicle color editing
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      autofocus: false,
                      controller: _controllerTextVehicleColor,
                      onChanged: (String contentValue) {
                        vehicleColor = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: VehicleInforTerm.color,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextVehicleColor.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //vehicle number plates editing
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      autofocus: false,
                      controller: _controllerTextVehicleNumberPlate,
                      onChanged: (String contentValue) {
                        vehicleNumberPlate = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: VehicleInforTerm.numberPlates,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextVehicleNumberPlate.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //vehicle description editing
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      maxLines: maxLine,
                      autofocus: false,
                      controller: _controllerTextVehicleDescription,
                      onChanged: (String contentValue) {
                        // fisrtName = contentValue;
                        // debugPrint(fisrtName);
                      },
                      decoration: InputDecoration(
                        labelText: VehicleInforTerm.description,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextVehicleDescription.clear();
                            setState(() {
                              maxLine = 1;
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox10H(),
              const Divider(
                thickness: 2,
                color: AppColor.lightGray1,
                height: 5,
              ),

              //Infor: Owner
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppTerm.owner,
                  style:
                      AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              //owner name
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextOwnerName,
                      onChanged: (String contentValue) {
                        ownerName = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: PersonalInforTerm.name,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextOwnerName.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //owner Dob
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextOwnerDoB,
                      onChanged: (String contentValue) {
                        ownerDoB = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: PersonalInforTerm.dob,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextOwnerDoB.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //owner address
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextOwnerAddress,
                      onChanged: (String contentValue) {
                        ownerAddress = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: PersonalInforTerm.addr,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextOwnerAddress.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //owner phone number
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextOwnerPhoneNumber,
                      onChanged: (String contentValue) {
                        ownerPhoneNumber = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: PersonalInforTerm.phoneNumber,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextOwnerPhoneNumber.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //owner citizen ID
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      maxLength: 12,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextOwnerCitizenID,
                      onChanged: (String contentValue) {
                        ownerCitizenID = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: PersonalInforTerm.citizenId,
                        suffixIcon: IconButton(
                          onPressed: _controllerTextOwnerCitizenID.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox50H()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleUpdatePersonalProfile() async {
    Map<String, dynamic> userInforUpdateData = <String, dynamic>{
      "name": ownerName,
      "phoneNumber": ownerPhoneNumber,
      "address": ownerAddress,
      "dateOfBirth": ownerDoB,
      "citizenNumber": ownerCitizenID
    };
    Map<String, dynamic> vehicleInforUpdateData = <String, dynamic>{
      "vehicle": {
        "brand": vehicleBrand,
        "model": vehicleModel,
        "color": vehicleColor,
        "licensePlate": vehicleNumberPlate,
      },
    };
    await PersonalUpdateBloc.updateProfileAndVehicleEvent(
        deviceId: deviceId,
        userInforUpdateData: userInforUpdateData,
        vehicleInforUpdateData: vehicleInforUpdateData);
  }

  void showAlertConfirmEditDone(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            // onPressed: () {
            //   Navigator.pop(context);
            // },
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AppNavigationConfig(
                  navigateKeyPersonal: false,
                ),
              ),
            ),

            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
