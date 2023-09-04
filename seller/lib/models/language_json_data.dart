class LanguageJsonData {
  int? status;
  String? message;
  int? total;
  Data? data;

  LanguageJsonData({this.status, this.message, this.total, this.data});

  LanguageJsonData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
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
  int? id;
  String? name;
  String? code;
  String? type;
  int? systemType;
  int? isDefault;
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
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    systemType = json['system_type'];
    isDefault = json['is_default'];
    jsonData = (json['json_data'] != null ? Map.from(json['json_data']) : null);
    systemTypeName = json['system_type_name'];
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
