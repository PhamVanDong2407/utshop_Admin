part of 'app_page.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const dashboard = _Paths.dashboard;
}

abstract class _Paths {
  _Paths._();
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
}
