import 'product_image_model.dart';

class FavoriteProductModel {
  FavoriteProductModel({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.discountPrice,
    this.images,
  });

  int? id;
  String? productId;
  String? name;
  int? price;
  int? discountPrice;
  List<ProductImageModel>? images;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    images = (json['images'] as List<dynamic>?)
        ?.map((e) => ProductImageModel.fromJson(e))
        .toList();
    price = json['price'];
    discountPrice = json['price_after_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['images'] = images;
    data['price'] = price;
    data['price_after_discount'] = discountPrice;

    return data;
  }
}
