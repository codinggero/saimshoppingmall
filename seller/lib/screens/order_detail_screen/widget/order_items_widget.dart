import 'package:flutter/material.dart';
import '../../../helper/utils/export.dart';

getItemDetailContainer({required String title, required String value}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          softWrap: true,
          style: TextStyle(color: ColorsRes.grey),
        ),
      ),
      Widgets.getSizedBox(width: 10),
      Expanded(
        child: Text(
          value,
          softWrap: true,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
    ],
  );
}
