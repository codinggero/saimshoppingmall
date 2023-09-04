class AppSettingsDeliveryBoy {
  int? status;
  String? message;
  int? total;
  AppSettingsDeliveryBoyData? data;

  AppSettingsDeliveryBoy({this.status, this.message, this.total, this.data});

  AppSettingsDeliveryBoy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    data = json['data'] != null
        ? AppSettingsDeliveryBoyData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AppSettingsDeliveryBoyData {
  String? appName;
  String? supportNumber;
  String? supportEmail;
  String? currentVersion;
  String? minimumVersionRequired;
  String? isVersionSystemOn;
  String? currency;
  String? currencyCode;
  String? decimalPoint;
  String? lowStockLimit;
  String? appModeSeller;
  String? googlePlaceApiKey;
  String? privacyPolicyDeliveryBoy;
  String? termsConditionsDeliveryBoy;
  String? iosIsVersionSystemOn;
  List<String>? allPermissions;

  AppSettingsDeliveryBoyData(
      {this.appName,
      this.supportNumber,
      this.supportEmail,
      this.currentVersion,
      this.minimumVersionRequired,
      this.isVersionSystemOn,
      this.currency,
      this.currencyCode,
      this.decimalPoint,
      this.lowStockLimit,
      this.appModeSeller,
      this.googlePlaceApiKey,
      this.privacyPolicyDeliveryBoy,
      this.termsConditionsDeliveryBoy,
      this.iosIsVersionSystemOn,
      this.allPermissions});

  AppSettingsDeliveryBoyData.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    supportNumber = json['support_number'];
    supportEmail = json['support_email'];
    currentVersion = json['current_version'];
    minimumVersionRequired = json['minimum_version_required'];
    isVersionSystemOn = json['is_version_system_on'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    decimalPoint = json['decimal_point'];
    lowStockLimit = json['low_stock_limit'];
    appModeSeller = json['app_mode_seller'];
    googlePlaceApiKey = json['google_place_api_key'];
    privacyPolicyDeliveryBoy = json['privacy_policy_delivery_boy'];
    termsConditionsDeliveryBoy = json['terms_conditions_delivery_boy'];
    iosIsVersionSystemOn = json['ios_is_version_system_on'];
    allPermissions = json['allPermissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['support_number'] = supportNumber;
    data['support_email'] = supportEmail;
    data['current_version'] = currentVersion;
    data['minimum_version_required'] = minimumVersionRequired;
    data['is_version_system_on'] = isVersionSystemOn;
    data['currency'] = currency;
    data['currency_code'] = currencyCode;
    data['decimal_point'] = decimalPoint;
    data['low_stock_limit'] = lowStockLimit;
    data['app_mode_seller'] = appModeSeller;
    data['google_place_api_key'] = googlePlaceApiKey;
    data['privacy_policy_delivery_boy'] = privacyPolicyDeliveryBoy;
    data['terms_conditions_delivery_boy'] = termsConditionsDeliveryBoy;
    data['ios_is_version_system_on'] = iosIsVersionSystemOn;
    data['allPermissions'] = allPermissions;
    return data;
  }
}
