import 'package:get/get.dart';
import 'package:utshopadmin/View/Home/Menu/OrderManagement/DetailOrder/detail_order.dart';
import 'package:utshopadmin/View/Home/Menu/OrderManagement/order_management.dart';
import 'package:utshopadmin/View/Home/Menu/ProductManagement/CreateProduct/create_product.dart';
import 'package:utshopadmin/View/Home/Menu/ProductManagement/EditProduct/edit_product.dart';
import 'package:utshopadmin/View/Home/Menu/ProductManagement/product_management.dart';
import 'package:utshopadmin/View/Home/Menu/ReveuneManagement/reveune_management.dart';
import 'package:utshopadmin/View/Home/Menu/UserManagement/user_management.dart';
import 'package:utshopadmin/View/Home/Menu/VoucherManagement/CreateVoucher/create_voucher.dart';
import 'package:utshopadmin/View/Home/Menu/VoucherManagement/EditVoucher/edit_voucher.dart';
import 'package:utshopadmin/View/Home/Menu/VoucherManagement/voucher_management.dart';
import 'package:utshopadmin/View/Home/home.dart';
import 'package:utshopadmin/View/Login/login.dart';
import 'package:utshopadmin/View/Notify/notify.dart';
import 'package:utshopadmin/View/Profile/ChangePassword/change_password.dart';
import 'package:utshopadmin/View/Profile/profile.dart';
import 'package:utshopadmin/View/dashboard.dart';
import 'package:utshopadmin/View/splash.dart';

part 'app_route.dart';

class AppPage {
  AppPage._();

  static const String initialRoute = Routes.splash;

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: Routes.splash, page: () => Splash()),
    GetPage(name: Routes.login, page: () => Login()),
    GetPage(name: Routes.dashboard, page: () => Dashboard()),
    GetPage(name: Routes.home, page: () => Home()),
    GetPage(name: Routes.productManagement, page: () => ProductManagement()),
    GetPage(name: Routes.createProduct, page: () => CreateProduct()),
    GetPage(name: Routes.editProduct, page: () => EditProduct()),
    GetPage(name: Routes.userManagement, page: () => UserManagement()),
    GetPage(name: Routes.orderManagement, page: () => OrderManagement()),
    GetPage(name: Routes.detailOrder, page: () => DetailOrder()),
    GetPage(name: Routes.voucherManagement, page: () => VoucherManagement()),
    GetPage(name: Routes.createVoucher, page: () => CreateVoucher()),
    GetPage(name: Routes.editVoucher, page: () => EditVoucher()),
    GetPage(name: Routes.revenueManagement, page: () => ReveuneManagement()),
    GetPage(name: Routes.notify, page: () => Notify()),
    GetPage(name: Routes.profile, page: () => Profile()),
    GetPage(name: Routes.changePassword, page: () => ChangePassword()),
  ];
}
