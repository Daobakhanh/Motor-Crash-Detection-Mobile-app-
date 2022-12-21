import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../../utils/validate_phone_number.dart';
import '../../navigation/pages/app_navigation.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController _controllerTextPhoneNumber;
  late TextEditingController _controllerTextOTP;
  String verificationIdVar = '';
  String phoneNumber = '';
  bool isPhoneValid = true;
  String smsOtpCode = '';
  bool isFullFillPhoneNumber = false;
  bool isFullFillOTP = false;

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
          title: const Text('Login'),
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
                      'Login to your account',
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
              const SizedBox(
                height: 40,
              ),
              LongStadiumButton(
                color: isFullFillPhoneNumber == true && isFullFillOTP == true
                    ? AppColor.pinkAccent
                    : AppColor.light,
                nameOfButton: "Login",
                onTap: !(isFullFillPhoneNumber == true && isFullFillOTP == true)
                    ? () {}
                    : () async {
                        // _controllerTextOTP.clear();
                        String accessToken = '';

                        try {
                          accessToken =
                              await getTokenWhenSignInWithCredential();
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                        if (accessToken.isNotEmpty) {
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
    auth.verifyPhoneNumber(
      phoneNumber: '+84${phoneNumber.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verificationIdVar = verificationId;
        debugPrint('verificationId : $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<String> getTokenWhenSignInWithCredential() async {
    String accessToken = '';
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdVar,
      smsCode: smsOtpCode,
    );

    await auth.signInWithCredential(credential);
    accessToken = await auth.currentUser!.getIdToken();

    print(accessToken);
    return accessToken;
  }
}
