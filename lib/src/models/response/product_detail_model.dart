import 'package:entrance_test/src/models/product_image_model.dart';

class ProductDetailModel {
  final int? status;
  final String? message;
  final ProductDetailData? data;

  ProductDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : ProductDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductDetailData {
  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? icountId;
  final String? unit;
  final String? code;
  final int? price;
  final int? priceAfterDiscount;
  final String? description;
  final int? weight;
  final bool? isPrescriptionDrugs;
  final List<ProductImageModel>? images;
  final List<Category>? categories;
  final String? refundTermsAndCondition;
  final String? ratingAverage;
  final int? ratingCount;
  final int? reviewCount;

  ProductDetailData({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.icountId,
    this.unit,
    this.code,
    this.price,
    this.priceAfterDiscount,
    this.description,
    this.weight,
    this.isPrescriptionDrugs,
    this.images,
    this.categories,
    this.refundTermsAndCondition,
    this.ratingAverage,
    this.ratingCount,
    this.reviewCount,
  });

  factory ProductDetailData.fromJson(Map<String, dynamic> json) =>
      ProductDetailData(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        icountId: json["icount_id"],
        unit: json["unit"],
        code: json["code"],
        price: json["price"],
        priceAfterDiscount: json["price_after_discount"],
        description: json["description"],
        weight: json["weight"],
        isPrescriptionDrugs: json["is_prescription_drugs"],
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => ProductImageModel.fromJson(e))
            .toList(),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        refundTermsAndCondition: json["refund_terms_and_condition"],
        ratingAverage: json["rating_average"],
        ratingCount: json["rating_count"],
        reviewCount: json["review_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "icount_id": icountId,
        "unit": unit,
        "code": code,
        "price": price,
        "price_after_discount": priceAfterDiscount,
        "description": description,
        "weight": weight,
        "is_prescription_drugs": isPrescriptionDrugs,
        "images": images,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "refund_terms_and_condition": refundTermsAndCondition,
        "rating_average": ratingAverage,
        "rating_count": ratingCount,
        "review_count": reviewCount,
      };
}

class Category {
  final String? id;
  final String? name;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final String? type;
  final int? position;
  final bool? isMenu;
  final Pivot? pivot;

  Category({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.type,
    this.position,
    this.isMenu,
    this.pivot,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        type: json["type"],
        position: json["position"],
        isMenu: json["is_menu"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "type": type,
        "position": position,
        "is_menu": isMenu,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  final String? productId;
  final String? categoryId;

  Pivot({
    this.productId,
    this.categoryId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        productId: json["product_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "category_id": categoryId,
      };
}
