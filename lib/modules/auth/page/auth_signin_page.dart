import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/auth/repo/auth_repo.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../../utils/validate_phone_number.dart';
import '../../app_state/repo/app_access_token_local_storage.dart';
import '../../app_state/repo/app_get_fcm_token_local_storage.dart';
import '../../navigation/pages/app_navigation.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
          title: const Text('Signin'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome back! ',
                      style: AppTextStyle.largeTitle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Signin to your account',
                      style: AppTextStyle.body17,
                    ),
                  ],
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
                      debugPrint(phoneNumber);
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
                              print('Error get OTP: $e');
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
                nameOfButton: "LOGIN",
                onTap: !(isFullFillPhoneNumber == true && isFullFillOTP == true)
                    ? () {}
                    : () async {
                        _controllerTextOTP.clear();
                        String accessToken = '';
                        try {
                          await signInWithCredential();
                          accessToken = await getAccessTokenFromFirebase();
                          await setAccessTokenToLocalStorage(
                              accessToken: accessToken);
                          final fcmToken = await getFcmToken();
                          await AuthRepo.signIn(fcmToken: fcmToken ?? '');
                          // await set
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                        if (accessToken.isNotEmpty) {
                          // ignore: avoid_print
                          DebugPrint.dataLog(
                              title: 'Auth signin page: accessToken ',
                              data: accessToken);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppNavigationConfig(),
                            ),
                          );
                        }
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

  Future<void> signInWithCredential() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdVar,
      smsCode: smsOtpCode,
    );
    await _auth.signInWithCredential(credential);
    // await _auth.signInWithCustomToken(token)
  }

  Future<String> getAccessTokenFromFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String accessToken;
    String? refreshToken;
    accessToken = await auth.currentUser!.getIdToken();
    refreshToken = auth.currentUser!.refreshToken;
    DebugPrint.dataLog(
        title: 'AUTH SIGNIN PAGE: RefreshToken', data: refreshToken);
    return accessToken;

    //need to extend exp time
    // getAccessTokenFromLocalStorage()
  }

  Future<String?> getFcmToken() async {
    final fcmToken = await _firebaseMessaging.getToken();
    DebugPrint.dataLog(title: 'FCM', data: fcmToken);
    return fcmToken;
  }
}
