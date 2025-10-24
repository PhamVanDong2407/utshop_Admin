import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Component/custom_dialog.dart';
import 'package:utshopadmin/Controller/Home/Menu/UserManagement/user_management_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';

class UserManagement extends StatelessWidget {
  UserManagement({super.key});

  final controller = Get.put(UserManagementController());

  Widget _buildUserCard({
    required String uuid,
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
              // Avatar
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

              // Thông tin người dùng
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
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "SĐT: $phone",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Vai trò: $role",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Trạng thái: $statusText",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu hành động
              PopupMenuButton<String>(
                icon: Icon(Icons.more_horiz_rounded, color: AppColor.grey),
                onSelected: (String result) async {
                  if (result == 'role') {
                    await controller.changeUserRole(uuid);
                  } else if (result == 'toggle') {
                    if (isActive) {
                      CustomDialog.show(
                        context: context,
                        color: Colors.red,
                        title: "Vô hiệu hóa người dùng",
                        content:
                            "Bạn có muốn vô hiệu hóa người dùng này không?",
                        onPressed: () async {
                          await controller.deactivateUser(uuid);
                        },
                      );
                    } else {
                      CustomDialog.show(
                        context: context,
                        color: Colors.green,
                        title: "Kích hoạt người dùng",
                        content: "Bạn có muốn kích hoạt người dùng này không?",
                        onPressed: () async {
                          await controller.activateUser(uuid);
                        },
                      );
                    }
                  } else if (result == 'delete') {
                    CustomDialog.show(
                      context: context,
                      color: AppColor.red,
                      title: "Xóa người dùng",
                      content: "Bạn có muốn xóa người dùng này không?",
                      onPressed: () async {
                        await controller.deleteUser(uuid);
                      },
                    );
                  }
                },

                itemBuilder:
                    (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        value: 'role',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_note_rounded,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(width: 12),
                            Text('Đổi vai trò'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'toggle',
                        child: Row(
                          children: [
                            Icon(
                              isActive
                                  ? Icons.toggle_off_rounded
                                  : Icons.toggle_on_rounded,
                              color: isActive ? AppColor.red : Colors.green,
                            ),
                            const SizedBox(width: 12),
                            Text(toggleActionText),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              color: AppColor.red,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Xóa người dùng',
                              style: TextStyle(color: AppColor.red),
                            ),
                          ],
                        ),
                      ),
                    ],
              ),
            ],
          ),
        ),
      ).paddingOnly(top: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Quản lý người dùng",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.userList.isEmpty) {
          return const Center(child: Text("Không có người dùng nào"));
        }

        return RefreshIndicator(
          color: AppColor.primary,
          onRefresh: controller.refreshUserList,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.userList.length,
            itemBuilder: (context, index) {
              final user = controller.userList[index];
              return _buildUserCard(
                uuid: user.uuid ?? '',
                name: user.name ?? 'Không tên',
                email: user.email ?? 'Không có email',
                phone: user.phone ?? 'Không có số',
                role: user.permissionName ?? 'Không xác định',
                isActive: user.status == 1,
                context: context,
              );
            },
          ),
        );
      }),
    );
  }
}
