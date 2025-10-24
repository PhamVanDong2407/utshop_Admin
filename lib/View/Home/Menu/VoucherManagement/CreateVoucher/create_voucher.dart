import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/VoucherManagement/CreateVoucher/create_voucher_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';

class CreateVoucher extends StatelessWidget {
  CreateVoucher({super.key});

  final controller = Get.put(CreateVoucherController());
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
          "Thêm mới mã giảm giá",
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
                controller: controller.codeController,
                decoration: _customInputDecoration(
                  hintText: "Nhập mã giảm giá",
                  prefixIcon: Icons.card_giftcard,
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Vui lòng nhập mã giảm giá'
                            : null,
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Mức giảm giá (%)", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.discountController,
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
                decoration: _customInputDecoration(
                  hintText: "Chọn ngày bắt đầu",
                  prefixIcon: Icons.calendar_today,
                ),
                onTap: () async {
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
                },
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Vui lòng chọn ngày bắt đầu'
                            : null,
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Ngày hết hạn", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.endDateController,
                readOnly: true,
                decoration: _customInputDecoration(
                  hintText: "Chọn ngày hết hạn",
                  prefixIcon: Icons.calendar_month,
                ),
                onTap: () async {
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
                },
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Vui lòng chọn ngày hết hạn'
                            : null,
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Giá trị đơn hàng tối thiểu", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.minOrderValueController,
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: "Nhập giá trị đơn hàng tối thiểu",
                  prefixIcon: Icons.rule,
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Vui lòng nhập giá trị tối thiểu'
                            : null,
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Số lượng sử dụng", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.usageLimitController,
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: "Nhập số lượng giới hạn sử dụng",
                  prefixIcon: Icons.confirmation_number,
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Vui lòng nhập số lượng'
                            : null,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
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
          child: ElevatedButton(
            onPressed:
                controller.isLoading.value
                    ? null
                    : () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await controller.createVoucher();
                      }
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child:
                controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      'Thêm mã giảm giá',
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
