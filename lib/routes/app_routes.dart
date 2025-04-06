import 'package:get/get.dart';

import '../futures/auth/screens/forgot_password/forgot_password.dart';
import '../futures/auth/screens/login/login.dart';
import '../futures/auth/screens/reset_password/reset_password.dart';
import '../futures/shop/screens/banners/all_banners/banners.dart';
import '../futures/shop/screens/banners/create_banner/create_banner.dart';
import '../futures/shop/screens/banners/edit_banner/edit_banners.dart';
import '../futures/shop/screens/categories/all_categories/categories.dart';
import '../futures/shop/screens/categories/create_categories/create_categories_banner.dart';
import '../futures/shop/screens/categories/edit_categories/edit_categories.dart';
import '../futures/shop/screens/dashboard/dashboard.dart';
import '../futures/shop/screens/occasions/all_occasions/occasions.dart';
import '../futures/shop/screens/occasions/create_occasions/create_occasions.dart';
import '../futures/shop/screens/occasions/edit_occasions/edit_occasions.dart';
import '../futures/shop/screens/orders/all_orders/orders.dart';
import '../futures/shop/screens/orders/order_details/order_details.dart';
import '../futures/shop/screens/products/all_products/products.dart';
import '../futures/shop/screens/products/create_products/create_products.dart';
import '../futures/shop/screens/products/edit_products/edit_products.dart';
import 'routes.dart';
import 'routes_middleware.dart';

class HAppRoutes {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: HRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: HRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(
        name: HRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
      name: HRoutes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [HRoutesMiddleware()],
    ),

    // Banners
    GetPage(
      name: HRoutes.banners,
      page: () => const BannersScreen(),
      middlewares: [HRoutesMiddleware()],
    ),
    GetPage(
      name: HRoutes.createBanner,
      page: () => const CreateBannersScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // create banner
    GetPage(
      name: HRoutes.editBanner,
      page: () => const EditBannersScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // edit banner

    // Categories

    GetPage(
      name: HRoutes.categories,
      page: () => const CategoriesScreen(),
      middlewares: [HRoutesMiddleware()],
    ),
    GetPage(
      name: HRoutes.createCategories,
      page: () => const CreateCategoriesScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // create categories
    GetPage(
      name: HRoutes.editCategories,
      page: () => const EditCategoriesScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // edit categories

    // Occasions

    GetPage(
      name: HRoutes.occasions,
      page: () => const OccasionsScreen(),
      middlewares: [HRoutesMiddleware()],
    ),
    GetPage(
      name: HRoutes.createOccasions,
      page: () => const CreateOccasionsScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // create Occasions
    GetPage(
      name: HRoutes.editOccasions,
      page: () => const EditOccasionsScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // edit Occasions

    // Products

    GetPage(
      name: HRoutes.products,
      page: () => const ProductsScreen(),
      middlewares: [HRoutesMiddleware()],
    ),
    GetPage(
      name: HRoutes.createProducts,
      page: () => const CreateProductsScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // create Products
    GetPage(
      name: HRoutes.editProducts,
      page: () => const EditProductsScreen(),
      middlewares: [HRoutesMiddleware()],
    ), // edit Products

    // Orders
    GetPage(
      name: HRoutes.orders,
      page: () => const OrdersScreen(),
      middlewares: [HRoutesMiddleware()],
    ),
    GetPage(
      name: HRoutes.ordersDetails,
      page: () => const OrderDetailsScreen(),
      middlewares: [HRoutesMiddleware()],
    ),
  ];
}
