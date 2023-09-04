class AppSettingsSeller {
  AppSettingsSeller({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final AppSettingsSellerData data;

  AppSettingsSeller.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = AppSettingsSellerData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final temp = <String, dynamic>{};
    temp['status'] = status;
    temp['message'] = message;
    temp['total'] = total;
    temp['data'] = data.toJson();
    return temp;
  }
}

class AppSettingsSellerData {
  AppSettingsSellerData({
    this.currency,
    this.currencyCode,
    this.decimalPoint,
    this.appModeSeller,
    this.privacyPolicySeller,
    this.termsConditionsSeller,
    this.googlePlaceApiKey,
    this.allPermissions,
  });

  late final String? currency;
  late final String? currencyCode;
  late final String? decimalPoint;
  late final String? appModeSeller;
  late final String? privacyPolicySeller;
  late final String? termsConditionsSeller;
  late final String? googlePlaceApiKey;
  late final List<String>? allPermissions;

  AppSettingsSellerData.fromJson(Map<String, dynamic> json) {
    currency = json['currency'].toString();
    currencyCode = json['currency_code'].toString();
    decimalPoint = json['decimal_point'].toString();
    appModeSeller = json['app_mode_seller'].toString();
    privacyPolicySeller = json['privacy_policy_seller'].toString();
    termsConditionsSeller = json['terms_conditions_seller'].toString();
    googlePlaceApiKey = json['google_place_api_key'].toString();
    allPermissions = List.castFrom<dynamic, String>(json['allPermissions']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currency'] = currency;
    data['currency_code'] = currencyCode;
    data['decimal_point'] = decimalPoint;
    data['app_mode_seller'] = appModeSeller;
    data['privacy_policy_seller'] = privacyPolicySeller;
    data['terms_conditions_seller'] = termsConditionsSeller;
    data['google_place_api_key'] = googlePlaceApiKey;
    data['allPermissions'] = allPermissions;
    return data;
  }
}
