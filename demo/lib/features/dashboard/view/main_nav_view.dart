import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/nav_controller.dart';
import 'dashboard_view.dart';
import '../../profile/view/profile_view.dart';
import '../../../core/constants/color_const.dart';

class MainNavView extends StatelessWidget {
  const MainNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      const DashboardView(),
      const Center(child: Text('Grid View Search')),
      const Center(child: Text('Notifications')),
      const ProfileView(),
    ];

    return Consumer<NavController>(
      builder: (context, nav, child) {
        return Scaffold(
          body: IndexedStack(
            index: nav.selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: ColorConst.white,
            unselectedItemColor: Colors.white24,
            type: BottomNavigationBarType.fixed,
            currentIndex: nav.selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) => nav.setIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
            ],
          ),
        );
      },
    );
  }
}
