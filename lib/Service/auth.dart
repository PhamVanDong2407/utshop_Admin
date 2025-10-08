import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Global/global_value.dart';
import 'package:utshopadmin/Route/app_page.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';
class Auth {
  static backLogin(bool isRun) async {
    if (!isRun) {
      return null;
    }

    await Utils.saveStringWithKey(Constant.ACCESS_TOKEN, '');
    await Utils.saveStringWithKey(Constant.REFRESH_TOKEN, '');
    await Utils.saveStringWithKey(Constant.EMAIL, '');
    await Utils.saveStringWithKey(Constant.PASSWORD, '');
    if (Get.currentRoute != Routes.login) {
      Get.offAllNamed(Routes.login);
    }
  }

  static login({String? email, String? password}) async {
    String emailPreferences = await Utils.getStringValueWithKey(Constant.EMAIL);
    String passwordPreferences = await Utils.getStringValueWithKey(
      Constant.PASSWORD,
    );

    String? hashedPassword;
    if (password != null) {
      hashedPassword = Utils.generateMd5(password);
    } else {
      hashedPassword = passwordPreferences;
    }

    Map<String, String> param = {
      "email": email ?? emailPreferences,
      "password": hashedPassword,
    };

    try {
      var response = await APICaller.getInstance().post(
        'v1/auth/login',
        body: param,
      );
      if (response != null) {
        GlobalValue.getInstance().setToken(
          'Bearer ${response['tokens']['access_token']}',
        );

        Utils.saveStringWithKey(
          Constant.ACCESS_TOKEN,
          response['tokens']['access_token'],
        );
        Utils.saveStringWithKey(
          Constant.REFRESH_TOKEN,
          response['tokens']['refresh_token'],
        );

        Utils.saveStringWithKey(Constant.NAME, response['data']['name'] ?? '');
        Utils.saveStringWithKey(
          Constant.AVATAR,
          response['data']['avatar'] ?? '',
        );

        Utils.saveStringWithKey(Constant.EMAIL, email ?? emailPreferences);
        Utils.saveStringWithKey(Constant.PASSWORD, hashedPassword);
        Get.offAllNamed(Routes.dashboard);
      } else {
        backLogin(true);
      }
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
      debugPrint('Error: $e');
    }
  }
}
