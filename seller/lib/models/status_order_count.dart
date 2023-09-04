class StatusOrderCount {
  StatusOrderCount({
    this.id,
    this.status,
    this.orderCount,
  });

  late final String? id;
  late final String? status;
  late final String? orderCount;

  StatusOrderCount.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'].toString();
    orderCount = json['order_count'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['order_count'] = orderCount;
    return data;
  }
}
