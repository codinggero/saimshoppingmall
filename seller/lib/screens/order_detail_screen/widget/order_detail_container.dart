import 'package:flutter/material.dart';
import '../../../helper/utils/export.dart';

getOrderDetailContainer({required String title, required String value}) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(
          title,
          softWrap: true,
          style: TextStyle(color: ColorsRes.grey),
        ),
      ),
      Widgets.getSizedBox(width: 10),
      Expanded(
        flex: 10,
        child: Text(
          value,
          softWrap: true,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
    ],
  );
}
