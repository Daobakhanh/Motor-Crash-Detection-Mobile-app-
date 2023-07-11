import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../lib.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  //firebase instance, variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AppAuthStateBloc appAuthStateBloc = AppAuthStateBloc();
  // AppAuthStateBloc? get appAuthStateBloc =>
  //     BlocProvider.of<AppAuthStateBloc>(context);

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
  bool isSignInPress = false;

  @override
  void dispose() {
    super.dispose();
    _controllerTextOTP.dispose();
    _controllerTextPhoneNumber.dispose();
    // _appAuthStateBloc.dispose();
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
              ),
            ),
            title: const Text(AppAuthTerm.authSignIn),
          ),
          body: BlocProvider(
            bloc: appAuthStateBloc,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppAuthTerm.welcomeBack,
                          style: AppTextStyle.largeTitle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppAuthTerm.signinToYourAccount,
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
                  !isSignInPress
                      ? LongStadiumButton(
                          width: widthScreen - 40,
                          color: isFullFillPhoneNumber == true &&
                                  isFullFillOTP == true
                              ? AppColors.pinkAccent
                              : AppColors.light,
                          nameOfButton: AppAuthTerm.authSignIn,
                          onTap: !(isFullFillPhoneNumber == true &&
                                  isFullFillOTP == true)
                              ? () {}
                              : () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // _controllerTextOTP.clear();
                                  String fbAccessToken = '';
                                  bool isSignInSuccessfull = false;

                                  try {
                                    await signInWithCredential();
                                    fbAccessToken =
                                        await getFbAccessTokenFromFirebase() ??
                                            '';
                                    await setFbUserAccessTokenToLocalStorage(
                                        accessToken: fbAccessToken);
                                    isSignInSuccessfull =
                                        await AuthBloc.signIn();

                                    // //TODO: delete one code line below if test OK
                                    // isSignInSuccessfull = true;
                                  } catch (e) {
                                    DebugPrint.authenLog(
                                      message: AppStateEnum.fail.toString(),
                                      currentFile: 'Auth_signin_page',
                                      title:
                                          'Auth signin page: error when call Signin Repo ',
                                    );
                                    // rethrow;
                                  }
                                  if (isSignInSuccessfull) {
                                    // ignore: avoid_print
                                    setState(() {
                                      isSignInPress = true;
                                    });

                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () async {
                                        isSignInPress = false;
                                        await appAuthStateBloc
                                            .changeAppAuthState(
                                                isUserTokenExpired: false);
                                        // Navigator.of(context).pushNamed(
                                        //     AppRoute.appNavigatorConfig);
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyApp()),
                                        );
                                      },
                                    );
                                    DebugPrint.dataLog(
                                        currentFile: 'auth_signin_page',
                                        title:
                                            'Auth signin page: Fb accessToken ',
                                        data: fbAccessToken);

                                    //FIXME: Change to real feature
                                    // ignore: use_build_context_synchronously
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const AppNavigationConfig(),
                                    //   ),
                                    // );
                                    // ignore: use_build_context_synchronously

                                    // await appAuthStateBloc.changeAppAuthState(
                                    //     isUserTokenExpired: false);
                                    // // ignore: use_build_context_synchronously
                                    // Navigator.of(context)
                                    //     .pushNamed(AppRoute.appNavigatorConfig);
                                  } else {
                                    //TODO: Show alert signin fail
                                  }
                                },
                        )
                      : const LongStadiumButtonIndicator(
                          color: AppColors.pinkAccent,
                        )
                ],
              ),
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
        debugPrint('verificationId : $verificationId');
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
  }

  Future<String?> getFbAccessTokenFromFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String accessToken;
    accessToken = await auth.currentUser!.getIdToken();
    print("accessToken: $accessToken");
    return accessToken;

    //need to extend exp time
    // getAccessTokenFromLocalStorage()
  }
}
