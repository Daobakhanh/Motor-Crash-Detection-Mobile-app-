import 'package:flutter/material.dart';

import '../../../lib.dart';

class ItemPersonalInforWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;
  const ItemPersonalInforWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.content});

  @override
  State<ItemPersonalInforWidget> createState() =>
      _ItemPersonalInforWidgetState();
}

class _ItemPersonalInforWidgetState extends State<ItemPersonalInforWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox15H(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: AppColor.grey,
            ),
            const SizedBox10W(),
            Text(
              '${widget.title}:  ',
              style: const TextStyle(
                  color: AppColor.grey, fontStyle: FontStyle.italic),
            ),
            Text(
              widget.content,
              style: AppTextStyle.body15.copyWith(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Text.rich(
            //   TextSpan(
            //     style: const TextStyle(
            //         color: AppColor.grey, fontStyle: FontStyle.italic),
            //     text: '${widget.title}: ',
            //     children: [
            //       TextSpan(
            //         text: widget.content,
            //         style: AppTextStyle.body17.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontStyle: FontStyle.normal,
            //             overflow: TextOverflow.ellipsis),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class ItemPersonalInforDescriptionWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;
  const ItemPersonalInforDescriptionWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.content});

  @override
  State<ItemPersonalInforDescriptionWidget> createState() =>
      _ItemPersonalInforDescriptionWidgetState();
}

class _ItemPersonalInforDescriptionWidgetState
    extends State<ItemPersonalInforDescriptionWidget> {
  bool hideBio = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox15H(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: AppColor.grey,
            ),
            const SizedBox10W(),
            Text(
              '${widget.title}:  ',
              style: const TextStyle(
                  color: AppColor.grey, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.content,
                    style: AppTextStyle.body15.copyWith(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                    maxLines: hideBio ? 2 : 10,
                    overflow:
                        hideBio ? TextOverflow.ellipsis : TextOverflow.clip,
                  ),
                  const SizedBox5H(),
                  GestureDetector(
                    child: Text(
                      hideBio ? "more" : "hide",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppTextColor.grey),
                    ),
                    onTap: () {
                      setState(() {
                        hideBio = !hideBio;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PersonalInforWidget extends StatelessWidget {
  const PersonalInforWidget({super.key, required this.personalInfor});
  final UserModel personalInfor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            AppTerm.owner,
            style: AppTextStyle.body17.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ItemPersonalInforWidget(
          icon: Icons.person,
          title: PersonalInforTerm.name,
          content: personalInfor.name ?? PersonalInforDataMock.name,
        ),
        ItemPersonalInforWidget(
          icon: Icons.calendar_month,
          title: PersonalInforTerm.dob,
          content: personalInfor.dateOfBirth ?? PersonalInforDataMock.dob,
        ),
        ItemPersonalInforWidget(
          icon: Icons.location_on,
          title: PersonalInforTerm.addr,
          content: personalInfor.address ?? PersonalInforDataMock.addr,
        ),
        ItemPersonalInforWidget(
          icon: Icons.phone,
          title: PersonalInforTerm.phoneNumber,
          content:
              personalInfor.phoneNumber ?? PersonalInforDataMock.phoneNumber,
        ),
        ItemPersonalInforWidget(
          icon: Icons.fingerprint,
          title: PersonalInforTerm.citizenId,
          content:
              personalInfor.citizenNumber ?? PersonalInforDataMock.citizenId,
        ),
      ],
    );
  }
}
