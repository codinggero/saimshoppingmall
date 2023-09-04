import 'package:flutter/material.dart';
import '../../../../helper/utils/export.dart';

getOrderStatusContainer({
  required BuildContext context,
  required String svgIconName,
  required String title,
  required bool isActive,
}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isActive ? ColorsRes.appColor : Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsetsDirectional.only(start: 10, bottom: 10, top: 10),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.all(10),
          child: Widgets.defaultImg(
              image: svgIconName,
              iconColor:
                  isActive ? ColorsRes.appColorWhite : ColorsRes.mainTextColor,
              width: 25,
              height: 25),
        ),
        Expanded(
          child: Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isActive
                    ? ColorsRes.appColorWhite
                    : ColorsRes.mainTextColor,
                fontWeight: FontWeight.w300),
          ),
        ),
      ],
    ),
  );
}
