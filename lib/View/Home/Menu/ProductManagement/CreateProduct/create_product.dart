import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/ProductManagement/CreateProduct/create_product_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Util/util.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct({super.key});

  final controller = Get.put(CreateProductController());
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text(
          "Thêm mới sản phẩm",
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
              _labelForm(label: "Tên sản phẩm", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.nameController,
                decoration: _customInputDecoration(
                  hintText: 'Nhập tên sản phẩm',
                  prefixIcon: Icons.shopping_bag_outlined,
                  iconColor: AppColor.primary.withAlpha(204),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên sản phẩm';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Mô tả sản phẩm", isRequired: false),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: _customInputDecoration(
                  hintText: 'Nhập mô tả sản phẩm',
                  prefixIcon: Icons.description_outlined,
                ),
              ),

              const SizedBox(height: 20),

              _labelForm(label: "Giá", isRequired: true),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: 'Nhập giá sản phẩm',
                  prefixIcon: Icons.attach_money_outlined,
                  iconColor: Colors.green.shade700,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giá sản phẩm';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Giá phải là số hợp lệ';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              _labelForm(label: "Danh mục sản phẩm", isRequired: true),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedCategory.value,
                  decoration: _customInputDecoration(
                    hintText: 'Chọn danh mục sản phẩm',
                    prefixIcon: Icons.category_outlined,
                  ).copyWith(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                  ),
                  isExpanded: true,
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                  items:
                      controller.categories.map<DropdownMenuItem<String>>((
                        category,
                      ) {
                        return DropdownMenuItem<String>(
                          value: category.uuid,
                          child: Text(category.name ?? ''),
                        );
                      }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng chọn danh mục sản phẩm';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        color: Colors.amber.shade800,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Sản phẩm phổ biến",
                        style: TextStyle(
                          color: AppColor.text1,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Switch(
                      value: controller.isPopular.value,
                      onChanged: (value) {
                        controller.isPopular.value = value;
                      },
                      activeTrackColor: AppColor.primary.withAlpha(128),
                      activeColor: AppColor.primary,
                      inactiveThumbColor: AppColor.grey,
                      inactiveTrackColor: AppColor.grey.withAlpha(128),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _labelForm(label: "Hình ảnh sản phẩm", isRequired: true),
              const SizedBox(height: 4),

              Obx(
                () =>
                    !controller.isImageValid.value
                        ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Vui lòng chọn ít nhất một hình ảnh sản phẩm',
                            style: TextStyle(color: AppColor.red, fontSize: 12),
                          ),
                        )
                        : const SizedBox.shrink(),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isImageValid.value = true;
                          controller.isShowMore.value = false;
                          Utils.getMultipleImagePicker().then((value) {
                            if (value != null) {
                              controller.imageFiles.addAll(value);
                            }
                          });
                        },
                        child: Container(
                          width: 82,
                          height: 82,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.primary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primary,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColor.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${controller.imageFiles.length} ảnh",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.text1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ...controller.imageFiles.asMap().entries.map((entry) {
                        int index = entry.key;
                        var file = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 82,
                                width: 82,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(file, fit: BoxFit.cover),
                                ),
                              ),

                              if (index == 0)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 27,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(10),
                                      ),
                                      color: Colors.black.withAlpha(105),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Ảnh Bìa',
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),

                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.imageFiles.remove(file);
                                    controller.validateImageSelection();
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withAlpha(105),
                                      border: Border.all(
                                        color: AppColor.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: AppColor.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              _labelForm(label: "Phiên bản sản phẩm", isRequired: true),
              const SizedBox(height: 8),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...controller.variants.asMap().entries.map((entry) {
                      int index = entry.key;
                      var variant = entry.value;

                      return Card(
                        color: AppColor.white,
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Phiên bản ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.removeVariant(index);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.red.withAlpha(128),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _labelForm(
                                          label: "Size",
                                          isRequired: true,
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          width: double.infinity,
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            value: controller.mapSizeToString(
                                              variant.size,
                                            ),
                                            decoration: _customInputDecoration(
                                              hintText: 'M, L, XL',
                                              prefixIcon:
                                                  Icons.straighten_outlined,
                                            ).copyWith(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12,
                                                  ),
                                            ),
                                            isExpanded: true,
                                            onChanged:
                                                (value) => controller
                                                    .updateVariantSize(
                                                      index,
                                                      value,
                                                    ),
                                            items:
                                                [
                                                  'M',
                                                  'L',
                                                  'XL',
                                                ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  },
                                                ).toList(),
                                            validator:
                                                (value) =>
                                                    (value == null ||
                                                            value.isEmpty)
                                                        ? 'Chọn size'
                                                        : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _labelForm(
                                          label: "Màu sắc",
                                          isRequired: true,
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          width: double.infinity,
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            value: controller.mapColorToString(
                                              variant.color,
                                            ),
                                            decoration: _customInputDecoration(
                                              hintText: 'Đỏ, Đen, Trắng',
                                              prefixIcon:
                                                  Icons.palette_outlined,
                                            ).copyWith(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12,
                                                  ),
                                            ),
                                            isExpanded: true,
                                            onChanged:
                                                (value) => controller
                                                    .updateVariantColor(
                                                      index,
                                                      value,
                                                    ),
                                            items:
                                                [
                                                  'Trắng',
                                                  'Đỏ',
                                                  'Đen',
                                                ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  },
                                                ).toList(),
                                            validator:
                                                (value) =>
                                                    (value == null ||
                                                            value.isEmpty)
                                                        ? 'Chọn màu'
                                                        : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _labelForm(
                                          label: "Giới tính",
                                          isRequired: true,
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          width: double.infinity,
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            value: controller.mapGenderToString(
                                              variant.gender,
                                            ),
                                            decoration: _customInputDecoration(
                                              hintText: 'Nam, Nữ',
                                              prefixIcon: Icons.people_outlined,
                                            ).copyWith(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12,
                                                  ),
                                            ),
                                            isExpanded: true,
                                            onChanged:
                                                (value) => controller
                                                    .updateVariantGender(
                                                      index,
                                                      value,
                                                    ),
                                            items:
                                                [
                                                  'Nam',
                                                  'Nữ',
                                                ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  },
                                                ).toList(),
                                            validator:
                                                (value) =>
                                                    (value == null ||
                                                            value.isEmpty)
                                                        ? 'Chọn giới tính'
                                                        : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _labelForm(
                                          label: "Loại",
                                          isRequired: true,
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          width: double.infinity,
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            value: controller.mapTypeToString(
                                              variant.type,
                                            ),
                                            decoration: _customInputDecoration(
                                              hintText: 'Quần, Áo',
                                              prefixIcon:
                                                  Icons.inventory_2_outlined,
                                            ).copyWith(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12,
                                                  ),
                                            ),
                                            isExpanded: true,
                                            onChanged:
                                                (value) => controller
                                                    .updateVariantType(
                                                      index,
                                                      value,
                                                    ),
                                            items:
                                                [
                                                  'Quần',
                                                  'Áo',
                                                ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  },
                                                ).toList(),
                                            validator:
                                                (value) =>
                                                    (value == null ||
                                                            value.isEmpty)
                                                        ? 'Chọn loại'
                                                        : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _labelForm(
                                    label: "Số lượng",
                                    isRequired: true,
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller:
                                        controller.stockControllers[index],
                                    keyboardType: TextInputType.number,
                                    decoration: _customInputDecoration(
                                      hintText: 'Nhập số lượng',
                                      prefixIcon:
                                          Icons.add_shopping_cart_outlined,
                                    ).copyWith(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 12,
                                          ),
                                    ),
                                    onChanged:
                                        (value) => controller
                                            .updateVariantStock(index, value),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nhập số lượng';
                                      }
                                      if (int.tryParse(value) == null ||
                                          int.parse(value) <= 0) {
                                        return 'Số > 0';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (true)
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => controller.addVariant(),
                              icon: Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Thêm phiên bản',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              SizedBox(height: 30),
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
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              if (_formKey.currentState?.validate() ?? false) {
                controller.createProduct(); // Gọi hàm mới với upload ảnh
              } else {
                Get.snackbar(
                  "Lỗi",
                  "Vui lòng điền đủ và chính xác các thông tin bắt buộc!",
                  backgroundColor: AppColor.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              }
            } else {
              Get.snackbar(
                "Lỗi",
                "Vui lòng điền đủ và chính xác các thông tin bắt buộc!",
                backgroundColor: AppColor.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
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
            'Thêm sản phẩm',
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
}
