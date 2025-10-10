import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Component/custom_dialog.dart';
import 'package:utshopadmin/Controller/Home/Menu/UserManagement/user_management_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';

class UserManagement extends StatelessWidget {
  UserManagement({super.key});

  final controller = Get.put(UserManagementController());

  Widget _buildStaticUserCard({
    required String name,
    required String email,
    required String phone,
    required String role,
    required bool isActive,
    required BuildContext context,
  }) {
    final borderColor = isActive ? AppColor.primary : AppColor.red;
    final statusColor = isActive ? Colors.green.shade600 : AppColor.red;
    final statusText = isActive ? "Hoạt động" : "Bị khóa";
    final toggleActionText = isActive ? "Vô hiệu hóa" : "Kích hoạt";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: borderColor, width: 2),
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: borderColor.withAlpha(150),
                    size: 40,
                  ),
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "SĐT: ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          phone,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "Vai trò: ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          role,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "Trạng thái: ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_horiz_rounded,
                  color: AppColor.grey,
                  size: 24,
                ),
                onSelected: (String result) {
                  if (result == 'role') {
                    controller.changeUserRole(name);
                  } else if (result == 'toggle') {
                    controller.toggleUserActivation(name, isActive);
                  } else if (result == 'delete') {
                    controller.deleteUser(name);
                  }
                },
                itemBuilder:
                    (BuildContext context) => <PopupMenuEntry<String>>[
                      // 1. Đổi vai trò (Change Role)
                      PopupMenuItem<String>(
                        value: 'role',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit_note_rounded,
                              color: Colors.blueGrey,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Đổi vai trò',
                              style: TextStyle(
                                color: AppColor.text1,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 2. Kích hoạt / Vô hiệu hóa (Toggle)
                      PopupMenuItem<String>(
                        value: 'toggle',
                        child: Row(
                          children: [
                            Icon(
                              isActive
                                  ? Icons.toggle_off_rounded
                                  : Icons.toggle_on_rounded,
                              color: isActive ? AppColor.red : Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              toggleActionText,
                              style: TextStyle(
                                color: isActive ? AppColor.red : Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. Xóa user (Delete)
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: GestureDetector(
                          onTap: () {
                            CustomDialog.show(
                              context: context,
                              color: AppColor.red,
                              title: "Xóa người dùng",
                              content:
                                  "Bạn có chắc muốn xóa người dùng này không?",
                              onPressed: () {},
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: AppColor.red,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Xóa user',
                                style: TextStyle(
                                  color: AppColor.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
              ),
            ],
          ),
        ),
      ),
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
          "Quản lý người dùng",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          _buildStaticUserCard(
            name: "Phạm Văn Đông",
            email: "dong@admin.com",
            phone: "0123456789",
            role: "ADMIN",
            isActive: true,
            context: context,
          ),

          _buildStaticUserCard(
            name: "Nguyễn Thị A",
            email: "nguyenthiA@user.com",
            phone: "0987654321",
            role: "USER",
            isActive: true,
            context: context,
          ),

          _buildStaticUserCard(
            name: "Trần Văn B",
            email: "tranvanb@user.com",
            phone: "0333444555",
            role: "USER",
            isActive: false,
            context: context,
          ),

          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        label: const Text(
          'Thêm mới',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8,
      ),
    );
  }
}
