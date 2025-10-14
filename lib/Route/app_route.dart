part of 'app_page.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
  static const productManagement = _Paths.productManagement;
  static const createProduct = _Paths.createProduct;
  static const editProduct = _Paths.editProduct;
  static const userManagement = _Paths.userManagement;
  static const orderManagement = _Paths.orderManagement;
  static const detailOrder = _Paths.detailOrder;
  static const voucherManagement = _Paths.voucherManagement;
  static const createVoucher = _Paths.createVoucher;
  static const editVoucher = _Paths.editVoucher;
  static const revenueManagement = _Paths.revenueManagement;
  static const notify = _Paths.notify;
  static const profile = _Paths.profile;
  static const changePassword = _Paths.changePassword;
}

abstract class _Paths {
  _Paths._();
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String productManagement = '/product-management';
  static const String createProduct = '/create-product';
  static const String editProduct = '/edit-product';
  static const String userManagement = '/user-management';
  static const String orderManagement = '/order-management';
  static const String detailOrder = '/detail-order';
  static const String voucherManagement = '/voucher-management';
  static const String createVoucher = '/create-voucher';
  static const String editVoucher = '/edit-voucher';
  static const String revenueManagement = '/revenue-management';
  static const String notify = '/notify';
  static const String profile = '/profile';
  static const String changePassword = '/change-password';
}
