import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future getAppSettings({required BuildContext context}) async {
  try {
    var response = await GeneralMethods.sendApiRequest(
        apiName: ApiAndParams.apiAppSettings,
        params: {},
        isPost: false,
        context: context);
    return json.decode(response);
  } catch (e) {
    rethrow;
  }
}
