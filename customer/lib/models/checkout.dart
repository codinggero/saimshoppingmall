class Checkout {
  String? status;
  String? message;
  String? total;
  DeliveryChargeData? data;

  Checkout({this.status, this.message, this.total, this.data});

  Checkout.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data =
        json['data'] != null ? DeliveryChargeData.fromJson(json['data']) : null;
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

class DeliveryChargeData {
  String? codAllowed;
  String? productVariantId;
  String? quantity;
  DeliveryCharge? deliveryCharge;
  String? totalAmount;
  PromocodeDetails? promocodeDetails;
  String? subTotal;
  String? savedAmount;

  DeliveryChargeData(
      {this.codAllowed,
      this.productVariantId,
      this.quantity,
      this.deliveryCharge,
      this.totalAmount,
      this.promocodeDetails,
      this.subTotal,
      this.savedAmount});

  DeliveryChargeData.fromJson(Map<String, dynamic> json) {
    codAllowed = json['cod_allowed'].toString();
    productVariantId = json['product_variant_id'].toString();
    quantity = json['quantity'].toString();
    deliveryCharge = json['delivery_charge'] != null
        ? DeliveryCharge.fromJson(json['delivery_charge'])
        : null;
    totalAmount = json['total_amount'].toString();
    promocodeDetails = json['promocode_details'] != null
        ? PromocodeDetails.fromJson(json['promocode_details'])
        : null;
    subTotal = json['sub_total'].toString();
    savedAmount = json['saved_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod_allowed'] = codAllowed;
    data['product_variant_id'] = productVariantId;
    data['quantity'] = quantity;
    if (deliveryCharge != null) {
      data['delivery_charge'] = deliveryCharge!.toJson();
    }
    data['total_amount'] = totalAmount;
    if (promocodeDetails != null) {
      data['promocode_details'] = promocodeDetails!.toJson();
    }
    data['sub_total'] = subTotal;
    data['saved_amount'] = savedAmount;
    return data;
  }
}

class DeliveryCharge {
  String? totalDeliveryCharge;
  List<SellersInfo>? sellersInfo;

  DeliveryCharge({this.totalDeliveryCharge, this.sellersInfo});

  DeliveryCharge.fromJson(Map<String, dynamic> json) {
    totalDeliveryCharge = json['total_delivery_charge'].toString();
    if (json['sellers_info'] != null) {
      sellersInfo = <SellersInfo>[];
      json['sellers_info'].forEach((v) {
        sellersInfo!.add(SellersInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_delivery_charge'] = totalDeliveryCharge;
    if (sellersInfo != null) {
      data['sellers_info'] = sellersInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellersInfo {
  String? sellerName;
  String? deliveryCharge;
  String? distance;
  String? duration;

  SellersInfo(
      {this.sellerName, this.deliveryCharge, this.distance, this.duration});

  SellersInfo.fromJson(Map<String, dynamic> json) {
    sellerName = json['seller_name'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    distance = json['distance'].toString();
    duration = json['duration'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_name'] = sellerName;
    data['delivery_charge'] = deliveryCharge;
    data['distance'] = distance;
    data['duration'] = duration;
    return data;
  }
}

class PromocodeDetails {
  String? id;
  String? isApplicable;
  String? message;
  String? promoCode;
  String? imageUrl;
  String? promoCodeMessage;
  String? total;
  String? discount;
  String? discountedAmount;

  PromocodeDetails(
      {this.id,
      this.isApplicable,
      this.message,
      this.promoCode,
      this.imageUrl,
      this.promoCodeMessage,
      this.total,
      this.discount,
      this.discountedAmount});

  PromocodeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    isApplicable = json['is_applicable'].toString();
    message = json['message'].toString();
    promoCode = json['promo_code'].toString();
    imageUrl = json['image_url'].toString();
    promoCodeMessage = json['promo_code_message'].toString();
    total = json['total'].toString();
    discount = json['discount'].toString();
    discountedAmount = json['discounted_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_applicable'] = isApplicable;
    data['message'] = message;
    data['promo_code'] = promoCode;
    data['image_url'] = imageUrl;
    data['promo_code_message'] = promoCodeMessage;
    data['total'] = total;
    data['discount'] = discount;
    data['discounted_amount'] = discountedAmount;
    return data;
  }
}
