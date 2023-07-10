import 'package:flutter/material.dart';

import '../../../lib.dart';

class LinkDeviceToUserWidget extends StatefulWidget {
  const LinkDeviceToUserWidget({
    super.key,
    this.isUseInHomePage = false,
  });
  final bool? isUseInHomePage;

  @override
  State<LinkDeviceToUserWidget> createState() => _LinkDeviceToUserWidgetState();
}

class _LinkDeviceToUserWidgetState extends State<LinkDeviceToUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            AppTerm.vehicle,
            style: AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox10H(),
        const Text(
          'Don\'t have device infor, Please add device',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PersonalLinkToDevice(isDoneCallback: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  widget.isUseInHomePage == false
                                      ? const PersonalPage()
                                      : const HomePage()),
                          (Route<dynamic> route) => false);
                    }),
                  ));
            },
            icon: const Icon(Icons.link),
            label: const Text('Add vehicle here'),
          ),
        ),
        const SizedBox10H(),
        const Divider(
          color: AppColor.lightGray2,
          thickness: 1.5,
          height: 1.5,
        ),
      ],
    );
  }
}
