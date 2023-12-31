import 'package:flutter/material.dart';
import '../utils/export.dart';

Future<Map<String, dynamic>> getCityByLatLongApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiCity,
    params: params,
    isPost: false,
  );

  Map<String, dynamic> mainData = await json.decode(response);

  return mainData;
}
