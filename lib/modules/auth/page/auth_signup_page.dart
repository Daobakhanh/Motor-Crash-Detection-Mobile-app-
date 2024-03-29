import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../lib.dart';

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
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            bottom: const PreferredSize(
                preferredSize: Size.zero,
                child: Divider(
                  height: 2,
                )),
            title: const Text(AppAuthTerm.authSignUp),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 40),
                  child: Text(
                    AppAuthTerm.createAnAccount,
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
                        labelText: AppFillTextTerm.yourPhoneNumber,
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
                        AppFillTextTerm.invalidPhoneNumber,
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
                          labelText: AppFillTextTerm.otpCode,
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
                              AppFillTextTerm.send,
                              textAlign: TextAlign.right,
                              style: AppTextStyle.body15
                                  .copyWith(color: AppColors.activeStateBlue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox50H(),
                LongStadiumButton(
                  width: widthScreen - 40,
                  color: isFullFillPhoneNumber == true && isFullFillOTP == true
                      ? AppColors.pinkAccent
                      : AppColors.light,
                  nameOfButton: AppAuthTerm.authNext,
                  onTap: !(isFullFillPhoneNumber == true &&
                          isFullFillOTP == true)
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
