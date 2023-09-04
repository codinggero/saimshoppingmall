import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

Future<Map<String, dynamic>> getTimeSlotSettingsApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
      apiName: ApiAndParams.apiTimeSlotsSettings,
      params: params,
      isPost: false,
      context: context);
  return json.decode(response);
}
