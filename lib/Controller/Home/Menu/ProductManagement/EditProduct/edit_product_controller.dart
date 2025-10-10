import 'dart:io';

import 'package:get/get.dart';

class EditProductController extends GetxController{
    final List<String> categories = ['Nam', 'Nữ', 'Quần', 'Áo'];
  RxBool isPopular = false.obs;
  RxBool isShowMore = true.obs;
  RxList<File> imageFiles = RxList<File>([]);
  Rx<String?> selectedCategory = Rx<String?>(null);
   RxBool isImageValid = true.obs; 

  void updateSelectedCategory(String? newValue) {
    selectedCategory.value = newValue;
  }

    bool validateImageSelection() {
    if (imageFiles.isEmpty) {
      isImageValid.value = false;
      return false;
    }
    isImageValid.value = true;
    return true;
  }
}