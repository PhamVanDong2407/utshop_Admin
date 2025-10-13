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
          "Chỉnh sửa mã giảm giá",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _labelForm(label: "Mã giảm giá", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
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

              _labelForm(label: "Mức giảm giá (%)", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: "Nhập mức giảm giá",
                  prefixIcon: Icons.percent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mức giảm giá';
                  }
                  final number = num.tryParse(value);
                  if (number == null || number <= 0 || number > 100) {
                    return 'Vui lòng nhập mức giảm giá hợp lệ (0-100)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Chi tiết mã giảm giá"),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: _customInputDecoration(
                  hintText: "Nhập chi tiết mã giảm giá",
                  prefixIcon: Icons.description,
                  iconColor: AppColor.primary,
                ),
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Ngày hết hạn", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                decoration: _customInputDecoration(
                  hintText: "Chọn ngày hết hạn",
                  prefixIcon: Icons.calendar_today,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    // Xử lý ngày được chọn
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn ngày hết hạn';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Điều kiện áp dụng", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: "Nhập điều kiện áp dụng",
                  prefixIcon: Icons.rule,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập điều kiện áp dụng';
                  }
                  final number = num.tryParse(value);
                  if (number == null || number < 0) {
                    return 'Vui lòng nhập điều kiện áp dụng hợp lệ';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Số lượng", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: "Nhập số lượng",
                  prefixIcon: Icons.confirmation_number,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số lượng';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Vui lòng nhập số lượng hợp lệ';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'Cập nhật mã giảm giá',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ).paddingOnly(bottom: 20),
    );
  }

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
