import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future registerFcmKey(
    {required BuildContext context, required String fcmToken}) async {
  await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiAddFcmToken,
    params: {ApiAndParams.fcmToken: fcmToken},
    isPost: true,
    context: context,
  );
}
