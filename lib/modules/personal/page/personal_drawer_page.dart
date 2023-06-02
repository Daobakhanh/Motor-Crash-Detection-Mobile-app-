import 'package:flutter/material.dart';

import '../../../lib.dart';

class PersonalDrawerPage extends StatefulWidget {
  const PersonalDrawerPage({super.key});

  @override
  State<PersonalDrawerPage> createState() => _PersonalDrawerPageState();
}

class _PersonalDrawerPageState extends State<PersonalDrawerPage> {
  bool isDarkMode = false;
  final AppAuthStateBloc _appAuthStateBloc = AppAuthStateBloc();
  AppThemeBloc? get _appThemeBloc => BlocProvider.of<AppThemeBloc>(context);
  @override
  void initState() {
    super.initState();
    _readThemeModeFromLocalStorage();
  }

  @override
  void dispose() {
    super.dispose();
    // _appAuthStateBloc.dispose();
    // _appThemeBloc!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _appAuthStateBloc,
      child: Drawer(
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
                    await _appThemeBloc!
                        .changeAppThemeStateAndEmitStream(value);
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

            //link User to device
            TextButton.icon(
              icon: const Icon(
                Icons.link,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalLinkToDevice(),
                    ));
              },
              label: const Text(
                'Link Device',
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
              onPressed: () {
                _appAuthStateBloc.logout();
                // ignore: use_build_context_synchronously
                logOutShowMyDialog(context);
              },
              icon: const Icon(
                Icons.logout,
              ),
              label: const Text(
                'Logout',
              ),
            )
          ],
        ),
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
}
