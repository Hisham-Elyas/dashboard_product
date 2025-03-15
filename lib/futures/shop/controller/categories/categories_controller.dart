import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/categories/categories_repo.dart';
import '../../model/category_model.dart';

class CategoriesController extends HBaseTableController<CategoryModel> {
  static CategoriesController get instance => Get.find();
  final _categoriesRepo = Get.put(CategoriesRepo());

  @override
  bool containsSearchQuer(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoriesRepo.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() {
    return _categoriesRepo.getAllcategories();
  }
}
