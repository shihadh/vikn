import '../config/app_config.dart';

class ApiConst {
  static const String login = '${AppConfig.accountsBaseUrl}/users/login';
  static const String saleListPage = '${AppConfig.viknBooksBaseUrl}/sales/sale-list-page/';
  
  static String userView(String userID) => '${AppConfig.viknUserViewBaseUrl}/users/user-view/$userID/';
}
