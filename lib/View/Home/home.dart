import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/home_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller.zoomDrawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: MenuScreen(controller: controller),
      mainScreen: MainScreen(controller: controller),
      borderRadius: 40.0,
      showShadow: true,
      angle: -10.0,
      drawerShadowsBackgroundColor: Colors.grey.withAlpha(50),
      slideWidth: MediaQuery.of(context).size.width * 0.75,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.easeIn,
      mainScreenTapClose: true,
    );
  }
}

class MainScreen extends StatelessWidget {
  final HomeController controller;
  const MainScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            controller.toggleDrawer();
          },
        ),
        title: const Text(
          'Trang chủ Admin',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                    "Tổng doanh thu",
                    "120.5M VND",
                    Icons.monetization_on,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDashboardCard(
                    "Tổng đơn hàng",
                    "32",
                    Icons.shopping_cart,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                    "Đang chuẩn bị",
                    "1,250",
                    Icons.checklist_outlined,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDashboardCard(
                    "Tổng sản phẩm",
                    "890",
                    Icons.inventory,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                    "Đơn đã bán",
                    "1,250",
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDashboardCard(
                    "Đang giao",
                    "890",
                    Icons.car_repair_outlined,
                    Colors.brown,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                    "Đơn hủy",
                    "1,250",
                    Icons.cancel,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: SizedBox.shrink()),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

Widget _buildDashboardCard(
  String title,
  String value,
  IconData icon,
  Color color,
) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

class MenuScreen extends StatelessWidget {
  final HomeController controller;
  const MenuScreen({super.key, required this.controller});

  final List<Map<String, dynamic>> menuItems = const [
    {
      'icon': Icons.inventory_2_outlined,
      'title': 'Quản lý sản phẩm',
      'route': '/product-management',
    },
    {
      'icon': Icons.people_alt_outlined,
      'title': 'Quản lý người dùng',
      'route': '/user-management',
    },
    {
      'icon': Icons.receipt_long_outlined,
      'title': 'Quản lý đơn hàng',
      'route': '/order-management',
    },
    {
      'icon': Icons.local_offer_outlined,
      'title': 'Quản lý mã giảm giá',
      'route': '/voucher-management',
    },
    {
      'icon': Icons.bar_chart_outlined,
      'title': 'Quản lý doanh thu',
      'route': '/revenue-management',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Colors.blue),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Text(
                        controller.name.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.email.value,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, indent: 20, endIndent: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final String routeName = item['route'];
                    return ListTile(
                      leading: Icon(item['icon'], color: Colors.white),
                      title: Text(
                        item['title'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        if (routeName.isNotEmpty) {
                          Get.toNamed(routeName);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
