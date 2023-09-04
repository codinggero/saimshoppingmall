import 'package:flutter/material.dart';
import '../../../../helper/utils/export.dart';

profileMenuWidget({required var profileMenus}) {
  return ListView.separated(
      padding: const EdgeInsetsDirectional.only(end: 5, start: 10),
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: profileMenus.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            profileMenus[index]['clickFunction'](context);
          },
          contentPadding: EdgeInsets.zero,
          leading: Container(
            decoration: DesignConfig.boxDecoration(
                ColorsRes.appColorLightHalfTransparent, 5),
            padding: const EdgeInsets.all(5),
            child: Widgets.defaultImg(
                image: profileMenus[index]['icon'],
                iconColor: ColorsRes.appColor,
                height: 20,
                width: 20),
          ),
          title: Text(
            profileMenus[index]['label'],
            style: Theme.of(context).textTheme.bodyMedium!.merge(
                  const TextStyle(letterSpacing: 0.5),
                ),
          ),
          trailing: const Icon(Icons.navigate_next),
        );
      });
}
