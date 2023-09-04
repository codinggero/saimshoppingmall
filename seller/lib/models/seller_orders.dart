import '../helper/utils/export.dart';

class SellerOrder {
  SellerOrder({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  late final String? status;
  late final String? message;
  late final String? total;
  late final SellerOrderData? data;

  SellerOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = SellerOrderData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final temp = <String, dynamic>{};
    temp['status'] = status;
    temp['message'] = message;
    temp['total'] = total;
    temp['data'] = data?.toJson();
    return temp;
  }
}

class SellerOrderData {
  SellerOrderData({
    this.statusOrderCount,
    this.orders,
  });

  late final List<StatusOrderCount>? statusOrderCount;
  late final List<SellerOrdersListItem>? orders;

  SellerOrderData.fromJson(Map<String, dynamic> json) {
    statusOrderCount = List.from(json['status_order_count'])
        .map(
          (e) => StatusOrderCount.fromJson(e),
        )
        .toList();
    orders = List.from(json['orders'])
        .map(
          (e) => SellerOrdersListItem.fromJson(e),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_order_count'] = statusOrderCount
        ?.map(
          (e) => e.toJson(),
        )
        .toList();
    data['orders'] = orders
        ?.map(
          (e) => e.toJson(),
        )
        .toList();
    return data;
  }
}

class SellerOrdersListItem {
  SellerOrdersListItem({
    this.id,
    this.deliveryBoyId,
    this.orderId,
    this.mobile,
    this.orderNote,
    this.total,
    this.deliveryCharge,
    this.taxAmount,
    this.taxPercentage,
    this.discount,
    this.finalTotal,
    this.paymentMethod,
    this.address,
    this.latitude,
    this.longitude,
    this.deliveryTime,
    this.activeStatus,
    this.pincodeId,
    this.addressId,
    this.createdAt,
    this.deliveryBoyName,
    this.userName,
    this.orderStatus,
  });

  late final String? id;
  late final String? deliveryBoyId;
  late final String? orderId;
  late final String? mobile;
  late final String? orderNote;
  late final String? total;
  late final String? deliveryCharge;
  late final String? taxAmount;
  late final String? taxPercentage;
  late final String? discount;
  late final String? finalTotal;
  late final String? paymentMethod;
  late final String? address;
  late final String? latitude;
  late final String? longitude;
  late final String? deliveryTime;
  late final String? activeStatus;
  late final String? pincodeId;
  late final String? addressId;
  late final String? createdAt;
  late final String? deliveryBoyName;
  late final String? userName;
  late final String? orderStatus;

  SellerOrdersListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    deliveryBoyId = json['delivery_boy_id'].toString();
    orderId = json['order_id'].toString();
    mobile = json['mobile'].toString();
    orderNote = json['order_note'].toString();
    total = json['total'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    taxAmount = json['tax_amount'].toString();
    taxPercentage = json['tax_percentage'].toString();
    discount = json['discount'].toString();
    finalTotal = json['final_total'].toString();
    paymentMethod = json['payment_method'].toString();
    address = json['address'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    deliveryTime = json['delivery_time'].toString();
    activeStatus = json['active_status'].toString();
    addressId = json['address_id'].toString();
    createdAt = json['created_at'].toString();
    deliveryBoyName = json['delivery_boy_name'].toString();
    userName = json['user_name'].toString();
    orderStatus = json['order_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['delivery_boy_id'] = deliveryBoyId;
    data['order_id'] = orderId;
    data['mobile'] = mobile;
    data['order_note'] = orderNote;
    data['total'] = total;
    data['delivery_charge'] = deliveryCharge;
    data['tax_amount'] = taxAmount;
    data['tax_percentage'] = taxPercentage;
    data['discount'] = discount;
    data['final_total'] = finalTotal;
    data['payment_method'] = paymentMethod;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['delivery_time'] = deliveryTime;
    data['active_status'] = activeStatus;
    data['pincode_id'] = pincodeId;
    data['address_id'] = addressId;
    data['created_at'] = createdAt;
    data['delivery_boy_name'] = deliveryBoyName;
    data['user_name'] = userName;
    data['order_status'] = orderStatus;
    return data;
  }
}
