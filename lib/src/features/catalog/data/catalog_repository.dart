
import 'product_api.dart';
import 'models/product_model.dart';

class CatalogRepository {
  CatalogRepository(this._productApi);

  final ProductApi _productApi;

  Future<List<ProductModel>> fetchAll() => _productApi.fetchProducts();

  Future<List<ProductModel>> fetchAllProducts() => _productApi.fetchProducts();

  Future<List<ProductModel>> fetchTamales() async {
    final products = await fetchAll();
    return products
        .where((product) => product.category == ProductCategory.tamal)
        .toList();
  }

  Future<List<ProductModel>> fetchBeverages() async {
    final products = await fetchAll();
    return products
        .where((product) => product.category == ProductCategory.beverage)
        .toList();
  }
}

