import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';

abstract class HBaseTableController<T> extends GetxController {
  RxBool isLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<List<T>> fetchItems();
  bool containsSearchQuer(T item, String query);
  Future<void> deleteItem(T item);
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    } catch (e) {
      HFullScreenLoader.stopLoading();
      isLoading.value = false;
      HLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchQuery(String query) {
    filteredItems
        .assignAll(allItems.where((item) => containsSearchQuer(item, query)));
    filteredItems.refresh();
  }

  void sortByProperty(
      int sortColumnIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort(
      (a, b) {
        if (ascending) {
          return property(a).compareTo(property(b));
        } else {
          return property(b).compareTo(property(a));
        }
      },
    );
  }

  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    filteredItems.refresh();
  }

  void updateItemFromLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filterdItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filterdItemIndex != -1) filteredItems[filterdItemIndex] = item;
  }

  void removeItemFormLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  Future<void> confirmAndDeleteItem(T item) async {
    Get.defaultDialog(
        title: 'Delete Item',
        content: const Text("Are you sure you want to delet this item?"),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
              onPressed: () async => await deteOnConfirm(item),
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: HSizes.buttonHeight / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HSizes.buttonRadius * 5))),
              child: const Text("Ok")),
        ),
        cancel: SizedBox(
          width: 60,
          child: ElevatedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: HSizes.buttonHeight / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HSizes.buttonRadius * 5))),
              child: const Text("Cancel")),
        ));
  }

  Future<void> deteOnConfirm(T item) async {
    try {
      HFullScreenLoader.stopLoading();
      HFullScreenLoader.popUpCircular();
      await deleteItem(item);
      removeItemFormLists(item);
      HFullScreenLoader.stopLoading();
      HLoaders.successSnackBar(
          title: "Item Deleted", message: "Your Item has Deleted");
    } catch (e) {
      HLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
