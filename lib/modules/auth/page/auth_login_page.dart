import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../navigation/pages/app_navigation.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _controllerTextPhoneNumber;
  late TextEditingController _controllerTextOTP;

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
    _controllerTextPhoneNumber = TextEditingController(text: "");
    _controllerTextOTP = TextEditingController(text: "");
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: TextField(
                      // maxLines: (address / 38 ).roundToDouble() + 1,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      maxLength: 10,
                      autofocus: false,
                      controller: _controllerTextPhoneNumber,
                      onChanged: (String contentValue) {
                        if (contentValue.length > 9) {
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
                        labelText: 'Your phone number',
                        suffixIcon: IconButton(
                          onPressed: _controllerTextPhoneNumber.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
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
                        if (contentValue.length > 5) {
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
                        labelText: 'OTP',
                        suffixIcon: TextButton(
                          onPressed: () {},
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
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppNavigationConfig(),
                          ),
                        );
                      },
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const AppNavigationConfig(),
                //     ),
                //   );
                // },
              ),
              // Container(
              //   // color: AppColors.activeStateGreen,
              //   alignment: Alignment.center,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       debugPrint('press login');
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const LoginOtpPage(),
              //         ),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       shape: const StadiumBorder(),
              //       backgroundColor: isFullFillPhoneNumber != true
              //           ? AppColor.pinkAccent
              //           : AppColor.light,
              //       fixedSize: const Size(350, 44),
              //     ),
              //     child: Text(
              //       'NEXT',
              //       style: AppTextStyle.body15.copyWith(
              //         fontWeight: FontWeight.bold,
              //         color: isFullFillPhoneNumber != false
              //             ? AppTextColor.dark
              //             : AppTextColor.light,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
