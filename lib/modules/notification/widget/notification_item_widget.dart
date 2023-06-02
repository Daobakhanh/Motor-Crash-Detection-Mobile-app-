import 'package:flutter/material.dart';
import '../../../lib.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModel notificationModel;

  const NotificationItem({
    super.key,
    required this.notificationModel,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    final title = widget.notificationModel.title ?? 'iSafe';
    final isRead = widget.notificationModel.isRead ?? true;
    final content = widget.notificationModel.content ?? 'iSafe notification';
    // final time = widget.notificationModel.createdAt!.seconds ?? 0;
    final notiType = widget.notificationModel.type ?? 0;

    final time = DateTimeFormat.dateTimeFormatDDMMYYFromTimestamp(
        timestamp: widget.notificationModel.createdAt!.seconds ?? 0);

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
            color: isRead ? AppColor.light : AppColor.lightGray1,
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
                  child: getIconImageNoti(notificationType: notiType),
                ),
                const SizedBox15W(),
                SizedBox(
                  width: screenWidth - 30 - 10 - 50 - 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '$title  ',
                          style: AppTextStyle.body15.copyWith(
                              fontWeight:
                                  isRead ? FontWeight.normal : FontWeight.bold,
                              color: AppTextColor.dark),
                          children: <TextSpan>[
                            TextSpan(
                              text: time,
                              // style: TextStyle(fontStyle: FontStyle.italic),
                              style: AppTextStyle.body15.copyWith(
                                fontStyle: FontStyle.italic,
                                color: AppTextColor.grey,
                                fontWeight: isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox10H(),
                      Text(
                        content,
                        style: TextStyle(
                          fontWeight:
                              isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                isRead
                    ? const SizedBox10W()
                    : Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: AppColor.activeStateBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
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

  Widget getIconImageNoti({required int notificationType}) {
    switch (notificationType) {
      case 1:
        return Image.asset('assets/images/fall_motorbike.png');
      case 2:
        return Image.asset('assets/images/accident_motorbike_2.png');
      case 3:
        return Image.asset('assets/images/thief_motorbike_1.png');
      case 4:
        return Image.asset('assets/images/thief_motorbike_1.png');
      case 5:
        return Image.asset('assets/images/sos.png');
      default:
        return Image.asset('assets/images/sos.png');
    }
  }
}
