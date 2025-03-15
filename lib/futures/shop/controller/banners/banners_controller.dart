import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/banners/banners_repo.dart';
import '../../model/banners_model.dart';

class BannersController extends HBaseTableController<BannersModel> {
  static BannersController get instance => Get.find();
  final _bannersRepoRepo = Get.put(BannersRepo());

  @override
  bool containsSearchQuer(BannersModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BannersModel item) async {
    await _bannersRepoRepo.deleteBanners(item.id);
  }

  @override
  Future<List<BannersModel>> fetchItems() {
    return _bannersRepoRepo.getAllBanners();
  }
}
