import 'dart:io';

import 'package:get/get.dart';

class CreateProductController extends GetxController {
  final List<String> categories = ['Nam', 'Nữ', 'Quần', 'Áo'];
  RxBool isPopular = false.obs;
  RxBool isShowMore = true.obs;
  RxList<File> imageFiles = RxList<File>([]);
  Rx<String?> selectedCategory = Rx<String?>(null);
   RxBool isImageValid = true.obs; 

  void updateSelectedCategory(String? newValue) {
    selectedCategory.value = newValue;
  }
}
