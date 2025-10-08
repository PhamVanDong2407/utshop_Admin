import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
    RxString email = ''.obs;

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
  }
}