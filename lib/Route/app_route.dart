part of 'app_page.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
  static const notify = _Paths.notify;
  static const profile = _Paths.profile;
}

abstract class _Paths {
  _Paths._();
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String notify = '/notify';
  static const String profile = '/profile';
}
