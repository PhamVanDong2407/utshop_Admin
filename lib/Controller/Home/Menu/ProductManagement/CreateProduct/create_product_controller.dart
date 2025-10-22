import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Model/Categories.dart';
import 'package:utshopadmin/Model/Product.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';

class CreateProductController extends GetxController {
  RxBool isPopular = false.obs;
  RxBool isShowMore = true.obs;
  RxList<File> imageFiles = RxList<File>([]);
  Rx<String?> selectedCategory = Rx<String?>(null);
  RxBool isImageValid = true.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final Map<int, TextEditingController> stockControllers = {};

  RxList<Variants> variants = <Variants>[].obs;
  RxList<Categories> categories = <Categories>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    addVariant();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockControllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }

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

  // Mapping functions for dropdown
  String mapSizeToString(int? size) {
    switch (size) {
      case 0:
        return 'M';
      case 1:
        return 'L';
      case 2:
        return 'XL';
      default:
        return 'M';
    }
  }

  int mapSize(String? size) {
    switch (size) {
      case 'M':
        return 0;
      case 'L':
        return 1;
      case 'XL':
        return 2;
      default:
        return 0;
    }
  }

  String mapGenderToString(int? gender) {
    switch (gender) {
      case 0:
        return 'Nam';
      case 1:
        return 'Nữ';
      default:
        return 'Nam';
    }
  }

  int mapGender(String? gender) {
    switch (gender) {
      case 'Nam':
        return 0;
      case 'Nữ':
        return 1;
      default:
        return 0;
    }
  }

  String mapColorToString(int? color) {
    switch (color) {
      case 0:
        return 'Trắng';
      case 1:
        return 'Đỏ';
      case 2:
        return 'Đen';
      default:
        return 'Trắng';
    }
  }

  int mapColor(String? color) {
    switch (color) {
      case 'Trắng':
        return 0;
      case 'Đỏ':
        return 1;
      case 'Đen':
        return 2;
      default:
        return 0;
    }
  }

  String mapTypeToString(int? type) {
    switch (type) {
      case 0:
        return 'Quần';
      case 1:
        return 'Áo';
      default:
        return 'Quần';
    }
  }

  int mapType(String? type) {
    switch (type) {
      case 'Quần':
        return 0;
      case 'Áo':
        return 1;
      default:
        return 0;
    }
  }

  void updateVariantSize(int index, String? value) {
    if (index >= 0 && index < variants.length && value != null) {
      variants[index] = Variants(
        uuid: variants[index].uuid,
        productUuid: variants[index].productUuid,
        size: mapSize(value),
        gender: variants[index].gender,
        color: variants[index].color,
        type: variants[index].type,
        stock: variants[index].stock,
        price: variants[index].price,
      );
      variants.refresh();
    }
  }

  void updateVariantColor(int index, String? value) {
    if (index >= 0 && index < variants.length && value != null) {
      variants[index] = Variants(
        uuid: variants[index].uuid,
        productUuid: variants[index].productUuid,
        size: variants[index].size,
        gender: variants[index].gender,
        color: mapColor(value),
        type: variants[index].type,
        stock: variants[index].stock,
        price: variants[index].price,
      );
      variants.refresh();
    }
  }

  void updateVariantGender(int index, String? value) {
    if (index >= 0 && index < variants.length && value != null) {
      variants[index] = Variants(
        uuid: variants[index].uuid,
        productUuid: variants[index].productUuid,
        size: variants[index].size,
        gender: mapGender(value),
        color: variants[index].color,
        type: variants[index].type,
        stock: variants[index].stock,
        price: variants[index].price,
      );
      variants.refresh();
    }
  }

  void updateVariantType(int index, String? value) {
    if (index >= 0 && index < variants.length && value != null) {
      variants[index] = Variants(
        uuid: variants[index].uuid,
        productUuid: variants[index].productUuid,
        size: variants[index].size,
        gender: variants[index].gender,
        color: variants[index].color,
        type: mapType(value),
        stock: variants[index].stock,
        price: variants[index].price,
      );
      variants.refresh();
    }
  }

  void updateVariantStock(int index, String? value) {
    if (index >= 0 && index < variants.length && value != null) {
      variants[index] = Variants(
        uuid: variants[index].uuid,
        productUuid: variants[index].productUuid,
        size: variants[index].size,
        gender: variants[index].gender,
        color: variants[index].color,
        type: variants[index].type,
        stock: int.tryParse(value) ?? 0,
        price: variants[index].price,
      );
      variants.refresh();
    }
  }

  void removeVariant(int index) {
    if (index >= 0 && index < variants.length) {
      variants.removeAt(index);
      stockControllers[index]?.dispose();
      stockControllers.remove(index);
      final newControllers = <int, TextEditingController>{};
      for (var i = 0; i < variants.length; i++) {
        newControllers[i] =
            stockControllers[i + 1] ??
            TextEditingController(text: variants[i].stock?.toString() ?? '');
      }
      stockControllers.clear();
      stockControllers.addAll(newControllers);
      variants.refresh();
    }
  }

  void addVariant() {
    final newVariant = Variants(
      uuid: '',
      productUuid: '', // Sẽ được cập nhật sau khi tạo sản phẩm
      size: 0,
      gender: 0,
      color: 0,
      type: 0,
      stock: 0,
      price: '0',
    );
    variants.add(newVariant);
    stockControllers[variants.length - 1] = TextEditingController(
      text: newVariant.stock?.toString() ?? '',
    );
    variants.refresh();
  }

  Future<void> getCategories() async {
    var res = await APICaller.getInstance().get('v1/category');

    if (res == null || res['error']?['code'] != 0) {
      var fetchedCategories =
          (res['data'] as List)
              .map((catJson) => Categories.fromJson(catJson))
              .toList();
      categories.assignAll(fetchedCategories);
      return;
    }
  }

  Future<void> createProduct() async {
    List<String> listAttachment = [];

    if (imageFiles.isNotEmpty) {
      var res = await APICaller.getInstance().uploadMultipartFiles(
        endpoint: 'v1/file/multiple-upload',
        files: imageFiles,
      );

      if (res == null || res['code'] != 200) {
        Utils.showSnackBar(
          title: 'Thông báo',
          message: res?['message'] ?? "Upload ảnh không thành công!",
        );
        return;
      }

      List<String> uploadedUrls = List<String>.from(res['files']);
      listAttachment.addAll(uploadedUrls);
    }

    List<Images> newImages = [];
    for (int i = 0; i < listAttachment.length; i++) {
      newImages.add(
        Images(
          uuid: '',
          productUuid: '',
          url: listAttachment[i],
          isMain: i == 0 ? 1 : 0,
        ),
      );
    }

    final productVariants =
        variants
            .map(
              (v) => Variants(
                uuid: '',
                productUuid: '',
                size: v.size ?? 0,
                gender: v.gender ?? 0,
                color: v.color ?? 0,
                type: v.type ?? 0,
                stock: v.stock ?? 0,
                price: v.price ?? '0',
              ),
            )
            .toList();

    final newProduct = Products(
      uuid: '',
      categoryUuid: selectedCategory.value ?? '',
      name: nameController.text.trim(),
      description:
          descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
      price: priceController.text.trim(),
      isPopular: isPopular.value ? 1 : 0,
      images: newImages,
      variants: productVariants,
    );

    try {
      final jsonBody = newProduct.toJson();

      var response = await APICaller.getInstance().post(
        'v1/product',
        body: jsonBody,
      );

      if (response != null && response['code'] == 201) {
        Get.back();
        Get.snackbar(
          'Thành công',
          response['message'] ?? 'Tạo sản phẩm thành công!',
          backgroundColor: AppColor.primary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        nameController.clear();
        descriptionController.clear();
        priceController.clear();
        imageFiles.clear();
        variants.clear();
        addVariant();
      } else {
        final errorMessage =
            response?['message'] ??
            response?['error']?['message'] ??
            "Lỗi không xác định";
        Get.snackbar(
          'Lỗi',
          'Tạo sản phẩm thất bại: $errorMessage',
          backgroundColor: AppColor.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint('❌ Lỗi tạo sản phẩm: $e');
      Get.snackbar(
        'Lỗi',
        'Tạo sản phẩm thất bại: $e',
        backgroundColor: AppColor.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
