import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/occasions/occasions_repo.dart';
import '../../model/occasions_model.dart';

class OccasionController extends HBaseTableController<OccasionsModel> {
  static OccasionController get instance => Get.find();
  final _occasionsRepoRepo = Get.put(OccasionsRepo());

  @override
  bool containsSearchQuer(OccasionsModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OccasionsModel item) async {
    await _occasionsRepoRepo.deleteOccasions(item.id);
  }

  @override
  Future<List<OccasionsModel>> fetchItems() {
    return _occasionsRepoRepo.getAllOccasions();
  }
}
