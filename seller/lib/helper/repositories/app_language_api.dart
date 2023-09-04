import 'package:flutter/material.dart';
import '../utils/export.dart';

Future<Map<String, dynamic>> getSystemLanguageApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiSystemLanguages,
    params: params,
    isPost: false,
  );

  return json.decode(response);
}

Future<Map<String, dynamic>> getAvailableLanguagesApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiSystemLanguages,
    params: params,
    isPost: false,
  );
  return json.decode(response);
}
