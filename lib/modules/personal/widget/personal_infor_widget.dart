import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../common/app_term.dart';
import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../widget/widget/stateless_widget/sized_box_widget.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
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
        ),
      ],
    );
  }
}
