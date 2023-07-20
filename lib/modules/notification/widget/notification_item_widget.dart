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
  final AppThemeBloc _appStateStreamControllerBloc = AppThemeBloc();
  final AppAuthStateBloc _appAuthStateStreamControllerBloc = AppAuthStateBloc();
  late final String title;
  late final bool isRead;
  late final String content;
  late final int notiType;

  late final String time;
  @override
  void dispose() {
    super.dispose();
    _appStateStreamControllerBloc.dispose();
    _appAuthStateStreamControllerBloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.notificationModel.title ?? 'iSafe';
    isRead = widget.notificationModel.isRead ?? true;
    content = widget.notificationModel.content ?? 'iSafe notification';
    notiType = widget.notificationModel.type ?? 0;

    time = DateTimeFormat.dateTimeFormatDDMMYYFromTimestamp(
        timestamp: widget.notificationModel.createdAt!.seconds ?? 0);
  }

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
            // height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            // margin: const EdgeInsets.symmetric(vertical: 10),
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    // color: AppColors.lightGray400,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    getIconImageNoti(notificationType: notiType),
                    color: isRead
                        ? (AppColors.greyBold)
                        : ((notiType == 1 || notiType == 2)
                            ? AppColors.alertRed
                            : null),
                  ),
                ),
                const SizedBox15W(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RichText(
                      //   text: TextSpan(
                      //     text: '$title        ',
                      //     style: AppTextStyle.body15
                      //         .copyWith(fontWeight: FontWeight.bold),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text: time,
                      //         // style: TextStyle(fontStyle: FontStyle.italic),
                      //         style: AppTextStyle.body15.copyWith(
                      //           // fontStyle: FontStyle.italic,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                              style: AppTextStyle.body15.copyWith(
                                fontWeight:
                                    isRead ? FontWeight.w300 : FontWeight.w700,
                              )),
                          Row(
                            children: [
                              Text(
                                time,
                                style: AppTextStyle.body15.copyWith(
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: isRead
                                      ? FontWeight.w300
                                      : FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBoxWithH(8),
                      Text(
                        content,
                        style: TextStyle(
                          fontWeight:
                              isRead ? FontWeight.w300 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                isRead
                    ? const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: SizedBox10W(),
                      )
                    : Container(
                        margin: const EdgeInsets.only(left: 13),
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.activeStateBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            thickness: 0.7,
            // color: AppColors.lightGray50,
          )
        ],
      ),
    );
  }

  String getIconImageNoti({required int notificationType}) {
    switch (notificationType) {
      case 1:
        return 'assets/images/fall_motorbike_2.png';
      case 2:
        return 'assets/images/accident_motorbike_5.png';
      case 3:
        return 'assets/images/thief_motorbike_1.png';
      case 4:
        return 'assets/images/thief_motorbike_1.png';
      case 5:
        return 'assets/images/sos.png';
      default:
        return 'assets/images/sos.png';
    }
  }

  // String checkNotiTitleCase({required String notiTypeTitle}) {
  //   switch (notiTypeTitle) {
  //     case "Stopped warning":
  //       return 'assets/images/fall_motorbike_2.png';
  //     case "Warning":
  //       return 'assets/images/accident_motorbike_5.png';
  //     case "":
  //       return 'assets/images/thief_motorbike_1.png';
  //     case "":
  //       return 'assets/images/thief_motorbike_1.png';
  //     case "":
  //       return 'assets/images/sos.png';
  //     default:
  //       return 'assets/images/sos.png';
  //   }
  // }
}
