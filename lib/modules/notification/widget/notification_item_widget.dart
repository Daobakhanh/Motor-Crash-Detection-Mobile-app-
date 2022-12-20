import 'package:elderly_fall_stray_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:elderly_fall_stray_detection/themes/app_color.dart';
import 'package:elderly_fall_stray_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  final bool isRead;
  const NotificationItem({super.key, required this.isRead});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    return InkWell(
      onTap: () {
        debugPrint('Press see Notification');
      },
      child: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            // margin: const EdgeInsets.symmetric(vertical: 10),
            color: widget.isRead ? AppColor.lightGray1 : AppColor.light,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: 50,
                  width: 50,
                  // color: AppColor.activeStateBlue,
                  child: Image.asset('assets/images/accident_motorbike_2.png'),
                ),
                const SizedBox5W(),
                SizedBox(
                  width: screenWidth - 30 - 10 - 50 - 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Title ',
                          style: AppTextStyle.body15.copyWith(
                              fontWeight: widget.isRead
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: AppTextColor.dark),
                          children: <TextSpan>[
                            TextSpan(
                              text: '13:30 18-2-2022',
                              // style: TextStyle(fontStyle: FontStyle.italic),
                              style: AppTextStyle.body15.copyWith(
                                fontStyle: FontStyle.italic,
                                color: AppTextColor.grey,
                                fontWeight: widget.isRead
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox10H(),
                      Text(
                        'Xe bị tai nan , thong bao SOS',
                        style: TextStyle(
                          fontWeight: widget.isRead
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.isRead
                    ? Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: AppColor.activeStateBlue,
                          shape: BoxShape.circle,
                        ),
                      )
                    : const SizedBox10W(),
              ],
            ),
          ),
          const Divider(
            height: 1.5,
            thickness: 1.5,
            color: AppColor.lightGray2,
          )
        ],
      ),
    );
  }
}
