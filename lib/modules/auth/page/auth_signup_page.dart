import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/auth/page/auth_signup_personal_infor_page.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../../utils/validate_phone_number.dart';
import '../../app_state/repo/app_access_token_local_storage_repo.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //firebase instance, variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String verificationIdVar = '';
  String fcmToken = '';

  //text controller
  late TextEditingController _controllerTextPhoneNumber;
  late TextEditingController _controllerTextOTP;
  String phoneNumber = '';
  String smsOtpCode = '';
  bool isFullFillPhoneNumber = false;
  bool isFullFillOTP = false;
  bool isPhoneValid = true;

  @override
  void dispose() {
    super.dispose();
    _controllerTextOTP.dispose();
    _controllerTextPhoneNumber.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerTextPhoneNumber = TextEditingController(text: phoneNumber);
    _controllerTextOTP = TextEditingController(text: smsOtpCode);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 40),
                child: Text(
                  'Create an account',
                  style: AppTextStyle.largeTitle,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    maxLength: 10,
                    autofocus: false,
                    controller: _controllerTextPhoneNumber,
                    onChanged: (String contentValue) {
                      phoneNumber = contentValue;
                      if (contentValue.isNotEmpty) {
                        setState(
                          () {
                            isPhoneValid = isValidPhoneNumber(contentValue);
                          },
                        );
                      }
                      // debugPrint(phoneNumber);
                      if (contentValue.length == 10) {
                        setState(
                          () {
                            isFullFillPhoneNumber = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            isFullFillPhoneNumber = false;
                          },
                        );
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Your phone number',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controllerTextPhoneNumber.clear();
                          isPhoneValid = true;
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              ),
              isPhoneValid
                  ? const SizedBox0H()
                  : const Text(
                      'Invalid phone number',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                    ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      maxLength: 6,
                      autofocus: false,
                      controller: _controllerTextOTP,
                      onChanged: (String contentValue) {
                        smsOtpCode = contentValue;
                        // debugPrint(smsOtpCode);
                        if (contentValue.length == 6) {
                          setState(
                            () {
                              isFullFillOTP = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              isFullFillOTP = false;
                            },
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'OTP',
                        suffixIcon: TextButton(
                          onPressed: () async {
                            try {
                              await verifyPhoneNumberFirebase();
                            } catch (e) {
                              // ignore: avoid_print
                              DebugPrint.dataLog(
                                data: e,
                                title: 'Error get OTP',
                                currentFile: 'auth_signup_page',
                              );
                            }
                          },
                          child: Text(
                            'Send',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.body15
                                .copyWith(color: AppColor.activeStateBlue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox50H(),
              LongStadiumButton(
                color: isFullFillPhoneNumber == true && isFullFillOTP == true
                    ? AppColor.pinkAccent
                    : AppColor.light,
                nameOfButton: "Next",
                onTap: !(isFullFillPhoneNumber == true && isFullFillOTP == true)
                    ? () {}
                    : () async {
                        // _controllerTextOTP.clear();
                        String? accessToken;

                        try {
                          accessToken =
                              await getAccessTokenWhenSignInWithCredential();
                          await setFbUserAccessTokenToLocalStorage(
                              accessToken: accessToken);
                        } catch (e) {
                          // ignore: avoid_print
                          DebugPrint.dataLog(
                            currentFile: 'auth_signup_page',
                            data: e,
                            title: 'get_fbaccessToken',
                          );
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupFillPersonalInforPage(
                              accessToken: accessToken,
                              phoneNumber: phoneNumber,
                            ),
                          ),
                        );
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumberFirebase() async {
    // ignore: avoid_print
    _auth.verifyPhoneNumber(
      phoneNumber: '+84${phoneNumber.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verificationIdVar = verificationId;
        // debugPrint('verificationId : $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<String> getAccessTokenWhenSignInWithCredential() async {
    String accessToken = '';
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdVar,
      smsCode: smsOtpCode,
    );

    await _auth.signInWithCredential(credential);
    accessToken = await _auth.currentUser!.getIdToken();

    // ignore: avoid_print
    // print(accessToken);
    return accessToken;
  }

  Future<String?> getFcmToken() async {
    final fcmToken = await _firebaseMessaging.getToken();
    return fcmToken;
  }
}
