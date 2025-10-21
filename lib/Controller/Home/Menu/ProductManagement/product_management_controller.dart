import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Model/ListProduct.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Global/constant.dart';

class ProductManagementController extends GetxController {
  RxList<ListProduct> productList = <ListProduct>[].obs;

  final String baseUrl = Constant.BASE_URL_IMAGE;

  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  Future<void> getProductList() async {
    try {
      var response = await APICaller.getInstance().get('v1/product');

      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'] as List<dynamic>;

        productList.value =
            data.map((item) {
              final product = ListProduct.fromJson(item);

              if ((product.mainImage ?? '').isNotEmpty) {
                product.mainImage = '$baseUrl${product.mainImage}';
              }

              return product;
            }).toList();
      }
    } catch (e) {
      debugPrint('Error fetching product list: $e');
    }
  }

  Future<void> refreshData() async {
    await getProductList();
  }

  Future<void> removeProduct(String uuid) async {
    try {
      var response = await APICaller.getInstance().delete('v1/product/$uuid');
      debugPrint('remove response: $response');

      // Sau khi xóa xong thì load lại danh sách
      await getProductList();
    } catch (e) {
      debugPrint('Error removing product: $e');
    }
  }
}
