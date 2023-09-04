import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future<Map<String, dynamic>> getUserDetail(
    {required BuildContext context}) async {
  var response = await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiUserDetails,
    params: {},
    isPost: false,
    context: context,
  );

  return json.decode(response);
}
