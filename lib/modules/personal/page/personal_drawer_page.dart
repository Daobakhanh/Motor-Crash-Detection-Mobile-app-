import 'dart:math';

import 'package:motorbike_crash_detection/modules/app_state/service/app_theme_state_local_storage.dart';
import 'package:motorbike_crash_detection/modules/auth/page/auth_page.dart';
import 'package:motorbike_crash_detection/themes/app_color.dart';
import 'package:flutter/material.dart';

import '../../../common/enum/app_theme_state_enum.dart';
import '../../app_state/bloc/app_state_bloc.dart';
import '../../providers/bloc_provider.dart';
import '../../widget/widget/stateless_widget/sized_box_widget.dart';

class PersonalDrawerPage extends StatefulWidget {
  const PersonalDrawerPage({super.key});

  @override
  State<PersonalDrawerPage> createState() => _PersonalDrawerPageState();
}

class _PersonalDrawerPageState extends State<PersonalDrawerPage> {
  bool isDarkMode = false;
  AppThemeBloc? get appThemeBloc => BlocProvider.of<AppThemeBloc>(context);
  @override
  void initState() {
    super.initState();
    _readThemeModeFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBoxWithH(100),

          //Dark mode feature
          Row(
            children: [
              const SizedBoxW(7),
              Icon(
                isDarkMode == true ? Icons.dark_mode : Icons.sunny,
                color: isDarkMode == true
                    ? AppColor.activeStateGrey
                    : AppColor.activeStateYellow,
              ),
              Switch(
                value: isDarkMode,
                onChanged: ((value) async {
                  setState(
                    () {
                      isDarkMode = value;
                    },
                  );
                  await appThemeBloc!.changeAppThemeStateAndEmitStream(value);
                  // await AppStateBloc().changeAppThemeStateAndEmitStream(value);
                }),
              )
            ],
          ),

          //Setting feature
          TextButton.icon(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {},
            label: const Text(
              'Setting',
            ),
          ),

          //Help center feature
          TextButton.icon(
            icon: const Icon(
              Icons.help_center,
            ),
            onPressed: () {},
            label: const Text(
              'Help',
            ),
          ),

          //Store feature
          TextButton.icon(
            icon: const Icon(
              Icons.store,
            ),
            onPressed: () {},
            label: const Text(
              'Store',
            ),
          ),

          //Logout feature
          TextButton.icon(
            onPressed: () => showConfirmLogoutDialog(),
            icon: const Icon(
              Icons.logout,
            ),
            label: const Text(
              'Logout',
            ),
          )
        ],
      ),
    );
  }

  void _readThemeModeFromLocalStorage() async {
    final readThemeState = await readAppThemeStateFromLocalStorage();
    if (readThemeState == AppThemeStateEnum.dark) {
      setState(() {
        isDarkMode = true;
      });
    } else {
      isDarkMode = false;
    }
  }

  void showConfirmLogoutDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Logout confirm'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                  (Route<dynamic> route) => false);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
