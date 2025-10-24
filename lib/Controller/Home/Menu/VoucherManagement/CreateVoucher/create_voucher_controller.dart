import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateVoucherController extends GetxController {

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController discountController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController endDateController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
  }
}
