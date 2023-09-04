import 'package:flutter/material.dart';
import '../utils/export.dart';

Widget messageContainer({
  required BuildContext context,
  required String text,
  required MessageType type,
}) {
  return Material(
    child: ToastAnimation(
      delay: Constant.messageDisplayDuration,
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [
                messageColors[type]!,
                messageColors[type]!.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: messageColors[type]!.withOpacity(0.5),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            children: [
              Widgets.getSizedBox(width: 15),
              messageIcon[type]!,
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextLabel(
                    text: text,
                    softWrap: true,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: messageColors[type],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              Widgets.getSizedBox(width: 10),
            ],
          )),
    ),
  );
}
