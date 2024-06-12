import '../product_model.dart';

class ProductRatingRequestModel {
  ProductRatingRequestModel(
      {ProductSort? sort, int? limit, int? page, String? productId})
      : _sortBy = SortType.getSortByValue(sort ?? ProductSort.newest),
        _sortOrder = SortType.getSortColumnValue(sort ?? ProductSort.newest),
        _limit = limit ?? 10,
        _productId = productId ?? '',
        _page = page ?? 0;

  final String _sortBy;
  final String _sortOrder;
  final int _limit;
  final int _page;
  final String _productId;

  Map<String, dynamic> toJson() => {
        'sort_column': _sortBy,
        'sort_order': _sortOrder,
        'limit': _limit,
        'page': _page,
        'product_id': _productId
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
