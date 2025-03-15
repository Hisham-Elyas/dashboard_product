import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/products/products_repo.dart';
import '../../model/products_model.dart';

class ProductsController extends HBaseTableController<ProductsModel> {
  static ProductsController get instance => Get.find();
  final _productsRepo = Get.put(ProductsRepo());

  @override
  bool containsSearchQuer(ProductsModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(ProductsModel item) async {
    await _productsRepo.deleteProducts(item.id);
  }

  @override
  Future<List<ProductsModel>> fetchItems() {
    return _productsRepo.getAllProducts();
  }
}
