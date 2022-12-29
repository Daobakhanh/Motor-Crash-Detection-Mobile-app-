import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/data/term/app_term.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../../utils/validate_phone_number.dart';
import '../../navigation/pages/app_navigation.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';
import '../bloc/auth_bloc.dart';

class SignupFillPersonalInforPage extends StatefulWidget {
  final String? accessToken;
  final String phoneNumber;
  const SignupFillPersonalInforPage(
      {Key? key, this.accessToken, required this.phoneNumber})
      : super(key: key);

  @override
  State<SignupFillPersonalInforPage> createState() =>
      _SignupFillPersonalInforPageState();
}

class _SignupFillPersonalInforPageState
    extends State<SignupFillPersonalInforPage> {
  //firebase instance, variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String verificationIdVar = '';
  String fcmToken = '';

  //text controller
  late TextEditingController _controllerTextUserName;
  late TextEditingController _controllerTextUserAddress;
  late TextEditingController _controllerTextUserDateOfBirth;
  late TextEditingController _controllerTextUserCitizenNumber;

  String userName = '';
  String userAddress = '';
  String? userDateOfBirth;
  String userCitizenNumber = '';

  bool isFullFillUserName = false;
  bool isFullFillAdress = false;
  bool isFullFillDoB = false;
  bool isFullFillCitizenNumber = false;
  bool isPhoneValid = true;

  @override
  void dispose() {
    super.dispose();
    _controllerTextUserName.dispose();
    _controllerTextUserAddress.dispose();
    _controllerTextUserCitizenNumber.dispose();
    _controllerTextUserDateOfBirth.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerTextUserName = TextEditingController(text: userName);
    _controllerTextUserAddress = TextEditingController(text: userAddress);
    _controllerTextUserCitizenNumber =
        TextEditingController(text: userCitizenNumber);
    _controllerTextUserDateOfBirth =
        TextEditingController(text: userDateOfBirth);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fill Information'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 40),
                  child: Text(
                    AppAuthTerm.fillAllToSubmit,
                    style: AppTextStyle.largeTitle,
                  ),
                ),
                // const SizedBox50H(),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      autofocus: false,
                      controller: _controllerTextUserName,
                      onChanged: (String contentValue) {
                        userName = contentValue;
                        if (contentValue.isNotEmpty) {
                          setState(
                            () {
                              isPhoneValid = isValidPhoneNumber(contentValue);
                            },
                          );
                        }
                        // debugPrint(userName);
                        if (contentValue.length > 5) {
                          setState(
                            () {
                              isFullFillUserName = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              isFullFillUserName = false;
                            },
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppFillTextTerm.yourFullName,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextUserName.clear();
                            // isPhoneValid = true;
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      keyboardType: TextInputType.streetAddress,
                      // maxLines: (userAddress.length > 18) ? 1 : 2,
                      // maxLength: 6,
                      autofocus: false,
                      controller: _controllerTextUserAddress,
                      onChanged: (String contentValue) {
                        userAddress = contentValue;
                        // debugPrint(smsOtpCode);

                        //detect full fill
                        if (contentValue.length > 10) {
                          setState(
                            () {
                              isFullFillAdress = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              isFullFillAdress = false;
                            },
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppFillTextTerm.yourAddress,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextUserAddress.clear();
                            // isPhoneValid = true;
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  // padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      autofocus: false,
                      controller: _controllerTextUserDateOfBirth,
                      onChanged: (String contentValue) {
                        userDateOfBirth = contentValue;
                        // debugPrint(smsOtpCode);

                        //detect full fill
                        if (contentValue.length >= 8) {
                          setState(
                            () {
                              isFullFillDoB = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              isFullFillDoB = false;
                            },
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppFillTextTerm.yourBirthday,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextUserDateOfBirth.clear();
                            // isPhoneValid = true;
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),

                //fill citizen ID number
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  // padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      keyboardType: TextInputType.number,
                      // maxLines: (userAddress.length > 18) ? 1 : 2,
                      // maxLength: 6,
                      autofocus: false,
                      controller: _controllerTextUserCitizenNumber,
                      onChanged: (String contentValue) {
                        userCitizenNumber = contentValue;
                        // debugPrint(smsOtpCode);

                        //detect full fill
                        if (contentValue.length >= 10) {
                          setState(
                            () {
                              isFullFillCitizenNumber = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              isFullFillCitizenNumber = false;
                            },
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppFillTextTerm.yourCitizenNumber,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controllerTextUserCitizenNumber.clear();
                            // isPhoneValid = true;
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox50H(),

                //Submit button
                LongStadiumButton(
                  color:
                      isFullFillInfor() ? AppColor.pinkAccent : AppColor.light,
                  nameOfButton: AppAuthTerm.authSubmit,
                  onTap: !(isFullFillInfor())
                      ? () {}
                      : () async {
                          // _controllerTextOTP.clear();
                          bool isSignUpSuccessfull = false;

                          try {
                            // await getAccessTokenWhenSignInWithCredential();
                            isSignUpSuccessfull = await AuthBloc.signUp(
                              createSignUpData(),
                            );
                          } catch (e) {
                            // ignore: avoid_print
                            DebugPrint.dataLog(
                              currentFile: 'signup_fill_infor',
                              title: 'Auth.bloc error',
                              data: e,
                            );
                          }
                          if (isSignUpSuccessfull) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AppNavigationConfig(),
                              ),
                            );
                          }
                        },
                ),
                const SizedBox50H(),
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
      phoneNumber: '+84${widget.phoneNumber.substring(1)}',
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
      smsCode: '123445',
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

  Map<String, dynamic> createSignUpData() {
    return {
      'name': userName.toString(),
      'phoneNumber': widget.phoneNumber.toString(),
      'address': userAddress.toString(),
      'avatarUrl': null,
      'dateOfBirth': userDateOfBirth.toString(),
      'citizenNumber': userCitizenNumber.toString(),
      'fcmTokens': [],
      'sosNumbers': []
    };
  }

  bool isFullFillInfor() {
    return isFullFillUserName == true &&
        isFullFillAdress == true &&
        isFullFillCitizenNumber == true &&
        isFullFillDoB == true;
  }
}
