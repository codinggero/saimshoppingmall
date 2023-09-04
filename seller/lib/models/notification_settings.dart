class NotificationSettings {
  String? status;
  String? message;
  String? total;
  List<NotificationSettingsData>? data;

  NotificationSettings({this.status, this.message, this.total, this.data});

  NotificationSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    if (json['data'] != null) {
      data = <NotificationSettingsData>[];
      json['data'].forEach((v) {
        data!.add(NotificationSettingsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationSettingsData {
  String? id;
  String? orderStatusId;
  String? mailStatus;
  String? mobileStatus;

  NotificationSettingsData(
      {this.id, this.orderStatusId, this.mailStatus, this.mobileStatus});

  NotificationSettingsData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    orderStatusId = json['order_status_id'].toString();
    mailStatus = json['mail_status'].toString();
    mobileStatus = json['mobile_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_status_id'] = orderStatusId;
    data['mail_status'] = mailStatus;
    data['mobile_status'] = mobileStatus;
    return data;
  }
}
