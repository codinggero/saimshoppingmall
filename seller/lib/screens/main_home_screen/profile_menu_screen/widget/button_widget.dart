import 'package:flutter/material.dart';
import '../../../../helper/utils/export.dart';

buttonWidget(var icon, String lbl, {required Function onClickAction}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: Constant.paddingOrMargin3),
    elevation: 0,
    child: InkWell(
      splashColor: ColorsRes.appColorLight,
      onTap: () {
        onClickAction();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          Card(
            shape: DesignConfig.setRoundedBorder(8),
            color: ColorsRes.appColorLightHalfTransparent,
            elevation: 0,
            child: Padding(padding: const EdgeInsets.all(5), child: icon),
          ),
          const SizedBox(height: 5),
          Text(lbl),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
