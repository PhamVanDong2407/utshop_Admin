import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/VoucherManagement/EditVoucher/edit_voucher_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';

class EditVoucher extends StatelessWidget {
  EditVoucher({super.key});

  final controller = Get.put(EditVoucherController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text(
          "Chi tiết mã giảm giá",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Obx(() {
          bool editable = controller.isEditing.value;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _labelForm(label: "Mã giảm giá", isRequired: true),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: editable,
                  controller: controller.codeController,
                  decoration: _customInputDecoration(
                    hintText: "Nhập mã giảm giá",
                    prefixIcon: Icons.card_giftcard,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã giảm giá';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _labelForm(label: "Mức giảm giá", isRequired: true),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: editable,
                  controller: controller.discountValueController,
                  keyboardType: TextInputType.number,
                  decoration: _customInputDecoration(
                    hintText: "Nhập mức giảm giá (%) hoặc VNĐ",
                    prefixIcon: Icons.percent,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mức giảm giá';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _labelForm(label: "Chi tiết mã giảm giá"),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: editable,
                  controller: controller.descriptionController,
                  maxLines: 4,
                  decoration: _customInputDecoration(
                    hintText: "Nhập chi tiết mã giảm giá",
                    prefixIcon: Icons.description,
                  ),
                ),

                const SizedBox(height: 20),

                _labelForm(label: "Ngày bắt đầu", isRequired: true),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.startDateController,
                  readOnly: true,
                  enabled: editable,
                  decoration: _customInputDecoration(
                    hintText: "Chọn ngày bắt đầu",
                    prefixIcon: Icons.calendar_today,
                  ),
                  onTap:
                      editable
                          ? () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              controller.startDateController.text =
                                  pickedDate.toString().split(' ')[0];
                            }
                          }
                          : null,
                ),

                const SizedBox(height: 20),

                _labelForm(label: "Ngày hết hạn", isRequired: true),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.endDateController,
                  readOnly: true,
                  enabled: editable,
                  decoration: _customInputDecoration(
                    hintText: "Chọn ngày hết hạn",
                    prefixIcon: Icons.calendar_month,
                  ),
                  onTap:
                      editable
                          ? () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              controller.endDateController.text =
                                  pickedDate.toString().split(' ')[0];
                            }
                          }
                          : null,
                ),

                const SizedBox(height: 20),

                _labelForm(
                  label: "Giá trị đơn hàng tối thiểu",
                  isRequired: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: editable,
                  controller: controller.minOrderValueController,
                  keyboardType: TextInputType.number,
                  decoration: _customInputDecoration(
                    hintText: "Nhập giá trị đơn hàng tối thiểu",
                    prefixIcon: Icons.rule,
                  ),
                ),

                const SizedBox(height: 20),

                _labelForm(label: "Giảm tối đa"),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: editable,
                  controller: controller.maxDiscountAmountController,
                  keyboardType: TextInputType.number,
                  decoration: _customInputDecoration(
                    hintText: "Nhập giá trị giảm tối đa",
                    prefixIcon: Icons.money_off,
                  ),
                ),

                const SizedBox(height: 20),

                _labelForm(label: "Giới hạn lượt sử dụng", isRequired: true),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: editable,
                  controller: controller.usageLimitController,
                  keyboardType: TextInputType.number,
                  decoration: _customInputDecoration(
                    hintText: "Nhập giới hạn lượt sử dụng",
                    prefixIcon: Icons.confirmation_number,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        bool editable = controller.isEditing.value;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              editable
                  ? Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await controller.updateVoucher();
                              Get.snackbar(
                                "Thành công",
                                "Đã cập nhật mã giảm giá",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                              controller.isEditing.value = false;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Cập nhật',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.cancelEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Hủy bỏ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : ElevatedButton(
                    onPressed: controller.toggleEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Chỉnh sửa mã giảm giá',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
        ).paddingOnly(bottom: 20);
      }),
    );
  }

  // ---- UI Helpers ----

  InputDecoration _customInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Color? iconColor,
  }) {
    final OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColor.grey.withAlpha(102), width: 1.0),
    );

    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColor.primary, width: 2.0),
    );

    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColor.red, width: 1.5),
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: AppColor.grey.withAlpha(204), fontSize: 14),
      errorStyle: TextStyle(color: AppColor.red, fontSize: 12),
      enabledBorder: baseBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder.copyWith(
        borderSide: BorderSide(color: AppColor.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      prefixIcon: Icon(prefixIcon, color: iconColor ?? AppColor.grey, size: 20),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Row _labelForm({required String label, bool isRequired = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.text1,
          ),
        ),
        const SizedBox(width: 4),
        if (isRequired)
          Text(
            "*",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.red,
            ),
          ),
      ],
    );
  }
}
