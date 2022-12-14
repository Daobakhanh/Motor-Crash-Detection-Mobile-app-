import 'package:elderly_fall_stray_detection/themes/app_color.dart';
import 'package:flutter/material.dart';

class PersonalDrawerPage extends StatefulWidget {
  const PersonalDrawerPage({super.key});

  @override
  State<PersonalDrawerPage> createState() => _PersonalDrawerPageState();
}

class _PersonalDrawerPageState extends State<PersonalDrawerPage> {
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    isDarkMode = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 7,
                ),
                Icon(
                  isDarkMode == true ? Icons.dark_mode : Icons.sunny,
                  color: isDarkMode == true
                      ? AppColor.activeStateGray
                      : Colors.blue,
                ),
                Switch(
                  value: isDarkMode,
                  onChanged: ((value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  }),
                )
              ],
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {},
              label: const Text(
                'Setting',
              ),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.help_center,
              ),
              onPressed: () {},
              label: const Text(
                'Help',
              ),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.store,
              ),
              onPressed: () {},
              label: const Text(
                'Store',
              ),
            ),
            TextButton.icon(
              onPressed: (() {}),
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
}
