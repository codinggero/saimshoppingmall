import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future<Map<String, dynamic>> getPlaceOrderApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
      apiName: ApiAndParams.apiPlaceOrder,
      params: params,
      isPost: true,
      context: context);
  return json.decode(response);
}
