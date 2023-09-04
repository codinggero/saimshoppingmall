class LanguageJsonData {
  String? status;
  String? message;
  String? total;
  Data? data;

  LanguageJsonData({this.status, this.message, this.total, this.data});

  LanguageJsonData.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? id;
  String? name;
  String? code;
  String? type;
  String? systemType;
  String? isDefault;
  Map<dynamic, dynamic>? jsonData;
  String? systemTypeName;

  Data(
      {this.id,
      this.name,
      this.code,
      this.type,
      this.systemType,
      this.isDefault,
      this.jsonData,
      this.systemTypeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    code = json['code'].toString();
    type = json['type'].toString();
    systemType = json['system_type'].toString();
    isDefault = json['is_default'].toString();
    jsonData = (json['json_data'] != null ? Map.from(json['json_data']) : null);
    systemTypeName = json['system_type_name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    data['system_type'] = systemType;
    data['is_default'] = isDefault;
    data['system_type_name'] = systemTypeName;
    if (jsonData != null) {
      data['json_data'] = jsonData!;
    }

    return data;
  }
}
