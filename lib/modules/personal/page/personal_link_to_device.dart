import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/personal/bloc/personal_bloc_link_device_user_bloc.dart';
import 'package:motorbike_crash_detection/modules/personal/bloc/personal_infor_bloc.dart';
import 'package:motorbike_crash_detection/modules/personal/page/personal_page.dart';

import '../../../data/term/app_term.dart';
import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../widget/widget/stateless_widget/sized_box_widget.dart';

class PersonalLinkToDevice extends StatefulWidget {
  const PersonalLinkToDevice({super.key});

  @override
  State<PersonalLinkToDevice> createState() => _PersonalLinkToDeviceState();
}

class _PersonalLinkToDeviceState extends State<PersonalLinkToDevice> {
  bool isDone = false;

  late TextEditingController _controllerTextDeviceId;
  late TextEditingController _controllerTextVerificationCode;

  String deviceId = '';
  String verificationCode = '';

  @override
  void initState() {
    _controllerTextDeviceId = TextEditingController(text: '');
    _controllerTextVerificationCode = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerTextDeviceId.dispose();
    _controllerTextVerificationCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTerm.personalLinkToDevice),
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
            onPressed: () async {
              // _handleUpdatePersonalProfile();
              await _handleLinkDeviceToUser();

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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppTerm.personalLinkToDeviceGuide,
                  style:
                      AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox10H(),

              //device Id
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      maxLength: 17,
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextDeviceId,
                      onChanged: (String contentValue) {
                        deviceId = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: LinkUserToDevice.deviceId,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextDeviceId.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //verificationCode
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: TextField(
                      maxLines: 1,
                      autofocus: false,
                      controller: _controllerTextVerificationCode,
                      onChanged: (String contentValue) {
                        verificationCode = contentValue;
                      },
                      decoration: InputDecoration(
                        labelText: LinkUserToDevice.verificationCode,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextVerificationCode.clear();
                          },
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
      ),
    );
  }

  Future<void> _handleLinkDeviceToUser() async {
    Map<String, dynamic> linkDeviceToUserData = <String, dynamic>{
      "deviceId": deviceId,
      "verificationCode": verificationCode
    };

    await PersonalLinkUserDeviceBloc.personalLinkUserDeviceEvent(
        linkDeviceToUser: linkDeviceToUserData);
  }
}