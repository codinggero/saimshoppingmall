import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future<Map<String, dynamic>> getLoginApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
      apiName: ApiAndParams.apiLogin,
      params: params,
      isPost: true,
      context: context);

  return json.decode(response);
}
