import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Model/Users.dart';
import 'package:utshopadmin/Service/api_caller.dart';

class UserManagementController extends GetxController {
  RxList<Users> userList = <Users>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserList();
  }

  Future<void> getUserList() async {
    try {
      isLoading.value = true;
      final response = await APICaller.getInstance().get('v1/user');

      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        userList.value = data.map((e) => Users.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint('❌ Lỗi khi tải danh sách người dùng: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUserList() async => getUserList();

  Future<void> changeUserRole(String uuid) async {
    try {
      final selectedRole = await _selectRoleDialog();
      if (selectedRole == null) return;

      final int permissionId = int.parse(selectedRole);

      var response = await APICaller.getInstance().put(
        'v1/user/$uuid/permission',
        body: {'permission_id': permissionId},
      );

      if (response['success'] == true || response['code'] == 200) {
        Get.snackbar('Thành công', 'Cập nhật vai trò người dùng thành công');
        await getUserList();
      }
    } catch (e) {
      debugPrint('Error changing user role: $e');
      Get.snackbar('Lỗi', 'Không thể đổi vai trò người dùng');
    }
  }

  Future<void> deactivateUser(String uuid) async {
    try {
      var response = await APICaller.getInstance().put(
        'v1/user/$uuid/status',
        body: {'status': 0},
      );

      if (response['success'] == true || response['code'] == 200) {
        Get.snackbar('Thành công', 'Đã vô hiệu hóa người dùng');
        await getUserList();
      }
    } catch (e) {
      debugPrint('Error deactivating user: $e');
      Get.snackbar('Lỗi', 'Không thể vô hiệu hóa người dùng');
    }
  }

  Future<void> activateUser(String uuid) async {
    try {
      var response = await APICaller.getInstance().put(
        'v1/user/$uuid/status',
        body: {'status': 1},
      );

      if (response['success'] == true || response['code'] == 200) {
        Get.snackbar('Thành công', 'Đã kích hoạt người dùng');
        await getUserList();
      }
    } catch (e) {
      debugPrint('❌ Lỗi khi kích hoạt người dùng: $e');
      Get.snackbar('Lỗi', 'Không thể kích hoạt người dùng');
    }
  }

  Future<void> deleteUser(String uuid) async {
    try {
      isLoading.value = true;
      final response = await APICaller.getInstance().delete('v1/user/$uuid');

      if (response != null &&
          (response['success'] == true || response['code'] == 200)) {
        userList.removeWhere((u) => u.uuid == uuid);
        Get.snackbar('Thành công', 'Đã xóa người dùng');
      } else {
        debugPrint('⚠️ Xóa thất bại: ${response?['message']}');
      }
    } catch (e) {
      debugPrint('❌ Lỗi khi xóa người dùng: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> _selectRoleDialog() async {
    final roles = {'1': 'User', '2': 'Admin'};

    return await Get.defaultDialog<String?>(
      title: 'Chọn vai trò mới',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            roles.entries
                .map(
                  (entry) => ListTile(
                    title: Text(entry.value),
                    onTap: () => Get.back(result: entry.key),
                  ),
                )
                .toList(),
      ),
    );
  }
}
