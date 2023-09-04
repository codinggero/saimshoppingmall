import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future getHomeScreenDataApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
      apiName: ApiAndParams.apiShop,
      params: params,
      isPost: false,
      context: context);

  return json.decode(response);
}
