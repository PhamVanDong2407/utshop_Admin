import 'package:get/get.dart';
import 'package:utshopadmin/View/Home/home.dart';
import 'package:utshopadmin/View/Login/login.dart';
import 'package:utshopadmin/View/Notify/notify.dart';
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
    GetPage(name: Routes.notify, page: () => Notify()),
    GetPage(name: Routes.profile, page: () => Profile()),
  ];
}
