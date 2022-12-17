import 'package:elderly_fall_stray_detection/common/app_term.dart';
import 'package:elderly_fall_stray_detection/modules/personal/page/personal_page.dart';
import 'package:elderly_fall_stray_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../navigation/pages/app_navigation.dart';

class PersonalEditInforPage extends StatefulWidget {
  const PersonalEditInforPage({super.key});

  @override
  State<PersonalEditInforPage> createState() => _PersonalEditInforPageState();
}

class _PersonalEditInforPageState extends State<PersonalEditInforPage> {
  int maxLine = 5;
  bool isDone = false;
  late TextEditingController _controllerTextColorOfVehicle;
  late TextEditingController _controllerTextDescriptionOfVehicle;
  late TextEditingController _controllerTextAddressOfOwner;

  @override
  void initState() {
    super.initState();
    _controllerTextColorOfVehicle = TextEditingController(text: 'Black');
    _controllerTextDescriptionOfVehicle =
        TextEditingController(text: MotorBikeInforTerm.mockDes);
    _controllerTextAddressOfOwner = TextEditingController(text: "Ta Quang Buu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // _handleUpdatePersonalProfile(fisrtName, lastName, bio);
              setState(() {
                isDone = !isDone;
              });
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
              });
              // Navigator.pop(context);
              // showAlertConfirmEditDone(context);
            },
            child: isDone
                ?
                // const CircularProgressIndicator(
                //     strokeWidth: 2,
                //   )
                const CupertinoActivityIndicator(
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
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Vehicle',
                style:
                    AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: SizedBox(
                  // ignore: unnecessary_null_in_if_null_operators
                  height: 50,
                  child: TextField(
                    autofocus: false,
                    controller: _controllerTextColorOfVehicle,
                    onChanged: (String contentValue) {
                      // fisrtName = contentValue;
                      // debugPrint(fisrtName);
                    },
                    decoration: InputDecoration(
                      labelText: 'Color',
                      suffixIcon: IconButton(
                        onPressed: _controllerTextColorOfVehicle.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: SizedBox(
                  // ignore: unnecessary_null_in_if_null_operators
                  // height: ,
                  child: TextField(
                    maxLines: maxLine,
                    autofocus: false,
                    controller: _controllerTextDescriptionOfVehicle,
                    onChanged: (String contentValue) {
                      // fisrtName = contentValue;
                      // debugPrint(fisrtName);
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controllerTextDescriptionOfVehicle.clear();
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
                    controller: _controllerTextAddressOfOwner,
                    onChanged: (String contentValue) {
                      // fisrtName = contentValue;
                      // debugPrint(fisrtName);
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      suffixIcon: IconButton(
                        onPressed: _controllerTextAddressOfOwner.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
