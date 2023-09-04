class DeliveryBoys {
  String? status;
  String? message;
  String? total;
  List<DeliveryBoysData>? data;

  DeliveryBoys({this.status, this.message, this.total, this.data});

  DeliveryBoys.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    if (json['data'] != null) {
      data = <DeliveryBoysData>[];
      json['data'].forEach((v) {
        data!.add(
          DeliveryBoysData.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this
          .data!
          .map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return data;
  }
}

class DeliveryBoysData {
  String? id;
  String? name;
  String? pendingOrderCount;

  DeliveryBoysData({this.id, this.name, this.pendingOrderCount});

  DeliveryBoysData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    pendingOrderCount = json['pending_order_count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pending_order_count'] = pendingOrderCount;
    return data;
  }
}
