class OrderDetail {
  String? status;
  String? message;
  String? total;
  OrderDetailData? data;

  OrderDetail({this.status, this.message, this.total, this.data});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = json['data'] != null ? OrderDetailData.fromJson(json['data']) : null;
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

class OrderDetailData {
  Order? order;
  List<OrderItems>? orderItems;

  OrderDetailData({this.order, this.orderItems});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(
          OrderItems.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (orderItems != null) {
      data['order_items'] = orderItems!
          .map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return data;
  }
}

class Order {
  String? id;
  String? userId;
  String? deliveryBoyId;
  String? mobile;
  String? orderNote;
  String? total;
  String? deliveryCharge;
  String? discount;
  String? promoDiscount;
  String? finalTotal;
  String? paymentMethod;
  String? address;
  String? latitude;
  String? longitude;
  String? deliveryTime;
  String? activeStatus;
  String? statusName;
  String? orderDate;
  String? orderId;
  String? type;
  String? userName;
  String? userEmail;
  String? alternateMobile;
  String? landmark;
  String? area;
  String? pincode;
  String? city;
  String? state;
  String? country;
  String? street;
  String? customerPrivacy;
  String? deliveryBoyName;

  Order(
      {this.id,
      this.userId,
      this.deliveryBoyId,
      this.mobile,
      this.orderNote,
      this.total,
      this.deliveryCharge,
      this.discount,
      this.promoDiscount,
      this.finalTotal,
      this.paymentMethod,
      this.address,
      this.latitude,
      this.longitude,
      this.deliveryTime,
      this.activeStatus,
      this.statusName,
      this.orderDate,
      this.orderId,
      this.type,
      this.userName,
      this.userEmail,
      this.alternateMobile,
      this.landmark,
      this.area,
      this.pincode,
      this.city,
      this.state,
      this.country,
      this.street,
      this.customerPrivacy,
      this.deliveryBoyName});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    deliveryBoyId = json['delivery_boy_id'].toString();
    mobile = json['mobile'].toString();
    orderNote = json['order_note'].toString();
    total = json['total'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    discount = json['discount'].toString();
    promoDiscount = json['promo_discount'].toString();
    finalTotal = json['final_total'].toString();
    paymentMethod = json['payment_method'].toString();
    address = json['address'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    deliveryTime = json['delivery_time'].toString();
    activeStatus = json['active_status'].toString();
    statusName = json['status_name'].toString();
    orderDate = json['created_at'] ?? "2023-05-16T07:38:36.000000Z";
    orderId = json['order_id'].toString();
    type = json['type'].toString();
    userName = json['user_name'].toString();
    userEmail = json['user_email'].toString();
    alternateMobile = json['alternate_mobile'].toString();
    landmark = json['landmark'].toString();
    area = json['area'].toString();
    pincode = json['pincode'].toString();
    city = json['city'].toString();
    state = json['state'].toString();
    country = json['country'].toString();
    street = json['street'].toString();
    customerPrivacy = json['customer_privacy'].toString();
    deliveryBoyName = json['delivery_boy_name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['delivery_boy_id'] = deliveryBoyId;
    data['mobile'] = mobile;
    data['order_note'] = orderNote;
    data['total'] = total;
    data['delivery_charge'] = deliveryCharge;
    data['discount'] = discount;
    data['promo_discount'] = promoDiscount;
    data['final_total'] = finalTotal;
    data['payment_method'] = paymentMethod;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['delivery_time'] = deliveryTime;
    data['active_status'] = activeStatus;
    data['status_name'] = statusName;
    data['created_at'] = orderDate;
    data['order_id'] = orderId;
    data['type'] = type;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['alternate_mobile'] = alternateMobile;
    data['landmark'] = landmark;
    data['area'] = area;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['street'] = street;
    data['customer_privacy'] = customerPrivacy;
    data['delivery_boy_name'] = deliveryBoyName;
    return data;
  }
}

class OrderItems {
  String? orderId;
  String? productName;
  String? variantName;
  String? deliveryBoyId;
  String? quantity;
  String? price;
  String? discountedPrice;
  String? taxAmount;
  String? taxPercentage;
  String? subTotal;
  String? mobile;
  String? total;
  String? deliveryCharge;
  String? finalTotal;
  String? paymentMethod;
  String? address;
  String? deliveryTime;
  String? userName;
  String? productId;

  OrderItems(
      {this.orderId,
      this.productName,
      this.variantName,
      this.deliveryBoyId,
      this.quantity,
      this.price,
      this.discountedPrice,
      this.taxAmount,
      this.taxPercentage,
      this.subTotal,
      this.mobile,
      this.total,
      this.deliveryCharge,
      this.finalTotal,
      this.paymentMethod,
      this.address,
      this.deliveryTime,
      this.userName,
      this.productId});

  OrderItems.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'].toString();
    productName = json['product_name'].toString();
    variantName = json['variant_name'].toString();
    deliveryBoyId = json['delivery_boy_id'].toString();
    quantity = json['quantity'].toString();
    price = json['price'].toString();
    discountedPrice = json['discounted_price'].toString();
    taxAmount = json['tax_amount'].toString();
    taxPercentage = json['tax_percentage'].toString();
    subTotal = json['sub_total'].toString();
    mobile = json['mobile'].toString();
    total = json['total'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    finalTotal = json['final_total'].toString();
    paymentMethod = json['payment_method'].toString();
    address = json['address'].toString();
    deliveryTime = json['delivery_time'].toString();
    userName = json['user_name'].toString();
    productId = json['product_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['product_name'] = productName;
    data['variant_name'] = variantName;
    data['delivery_boy_id'] = deliveryBoyId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    data['tax_amount'] = taxAmount;
    data['tax_percentage'] = taxPercentage;
    data['sub_total'] = subTotal;
    data['mobile'] = mobile;
    data['total'] = total;
    data['delivery_charge'] = deliveryCharge;
    data['final_total'] = finalTotal;
    data['payment_method'] = paymentMethod;
    data['address'] = address;
    data['delivery_time'] = deliveryTime;
    data['user_name'] = userName;
    data['product_id'] = productId;
    return data;
  }
}
