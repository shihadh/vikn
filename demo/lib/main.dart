import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/login/controller/login_controller.dart';
import 'features/login/view/login_view.dart';
import 'features/dashboard/view/dashboard_view.dart';
import 'features/sale_list/controller/sale_controller.dart';
import 'features/sale_list/view/sale_list_view.dart';
import 'features/profile/controller/profile_controller.dart';
import 'features/profile/view/profile_view.dart';
import 'features/filter/view/filter_view.dart';

import 'features/dashboard/controller/nav_controller.dart';
import 'features/dashboard/view/main_nav_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => NavController()),
        ChangeNotifierProvider(create: (_) => SaleController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: const CabZingApp(),
    ),
  );
}

class CabZingApp extends StatelessWidget {
  const CabZingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CabZing',
      theme: AppTheme.darkTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/main': (context) => const MainNavView(),
        '/dashboard': (context) => const DashboardView(),
        '/sale-list': (context) => const SaleListView(),
        '/profile': (context) => const ProfileView(),
        '/filter': (context) => const FilterView(),
      },
    );
  }
}
