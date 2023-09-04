class ProductListItem {
  String? id;
  String? name;
  String? taxId;
  String? brandId;
  String? slug;
  String? categoryId;
  String? indicator;
  String? manufacturer;
  String? madeIn;
  String? status;
  String? isUnlimitedStock;
  String? totalAllowedQuantity;
  String? taxIncludedInPrice;
  String? longitude;
  String? latitude;
  String? maxDeliverableDistance;
  bool? isDeliverable;
  bool? isFavorite;
  List<Variants>? variants;
  String? imageUrl;

  ProductListItem(
      {this.id,
      this.name,
      this.taxId,
      this.brandId,
      this.slug,
      this.categoryId,
      this.indicator,
      this.manufacturer,
      this.madeIn,
      this.status,
      this.isUnlimitedStock,
      this.totalAllowedQuantity,
      this.taxIncludedInPrice,
      this.longitude,
      this.latitude,
      this.maxDeliverableDistance,
      this.isDeliverable,
      this.isFavorite,
      this.variants,
      this.imageUrl});

  ProductListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    taxId = json['tax_id'].toString();
    brandId = json['brand_id'].toString();
    slug = json['slug'].toString();
    categoryId = json['category_id'].toString();
    indicator = json['indicator'].toString();
    manufacturer = json['manufacturer'].toString();
    madeIn = json['made_in'].toString();
    status = json['status'].toString();
    isUnlimitedStock = json['is_unlimited_stock'].toString();
    totalAllowedQuantity = json['total_allowed_quantity'].toString();
    taxIncludedInPrice = json['tax_included_in_price'].toString();
    longitude = json['longitude'].toString();
    latitude = json['latitude'].toString();
    maxDeliverableDistance = json['max_deliverable_distance'].toString();
    isDeliverable = json['is_deliverable'];
    isFavorite = json['is_favorite'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tax_id'] = taxId;
    data['brand_id'] = brandId;
    data['slug'] = slug;
    data['category_id'] = categoryId;
    data['indicator'] = indicator;
    data['manufacturer'] = manufacturer;
    data['made_in'] = madeIn;
    data['status'] = status;
    data['is_unlimited_stock'] = isUnlimitedStock;
    data['total_allowed_quantity'] = totalAllowedQuantity;
    data['tax_included_in_price'] = taxIncludedInPrice;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['max_deliverable_distance'] = maxDeliverableDistance;
    data['is_deliverable'] = isDeliverable;
    data['is_favorite'] = isFavorite;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    data['image_url'] = imageUrl;
    return data;
  }
}

class Variants {
  String? id;
  String? type;
  String? status;
  String? measurement;
  String? price;
  String? discountedPrice;
  String? stock;
  String? stockUnitName;
  String? isUnlimitedStock;
  String? cartCount;
  String? taxableAmount;

  Variants(
      {this.id,
      this.type,
      this.status,
      this.measurement,
      this.price,
      this.discountedPrice,
      this.stock,
      this.stockUnitName,
      this.isUnlimitedStock,
      this.cartCount,
      this.taxableAmount});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    status = json['status'].toString();
    measurement = json['measurement'].toString();
    price = json['price'].toString();
    discountedPrice = json['discounted_price'].toString();
    stock = json['stock'].toString();
    stockUnitName = json['stock_unit_name'].toString();
    isUnlimitedStock = json['is_unlimited_stock'].toString();
    cartCount = json['cart_count'].toString();
    taxableAmount = json['taxable_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['status'] = status;
    data['measurement'] = measurement;
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    data['stock'] = stock;
    data['stock_unit_name'] = stockUnitName;
    data['is_unlimited_stock'] = isUnlimitedStock;
    data['cart_count'] = cartCount;
    data['taxable_amount'] = taxableAmount;
    return data;
  }
}
