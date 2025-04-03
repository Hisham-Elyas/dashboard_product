import 'package:get/get.dart';

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
import '../futures/shop/screens/products/all_products/products.dart';
import '../futures/shop/screens/products/create_products/create_products.dart';
import '../futures/shop/screens/products/edit_products/edit_products.dart';
import 'routes.dart';

class HAppRoutes {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: HRoutes.dashboard, page: () => const DashboardScreen()),

    // Banners
    GetPage(name: HRoutes.banners, page: () => const BannersScreen()),
    GetPage(
        name: HRoutes.createBanner,
        page: () => const CreateBannersScreen()), // create banner
    GetPage(
        name: HRoutes.editBanner,
        page: () => const EditBannersScreen()), // edit banner

    // Categories

    GetPage(name: HRoutes.categories, page: () => const CategoriesScreen()),
    GetPage(
        name: HRoutes.createCategories,
        page: () => const CreateCategoriesScreen()), // create categories
    GetPage(
        name: HRoutes.editCategories,
        page: () => const EditCategoriesScreen()), // edit categories

    // Occasions

    GetPage(name: HRoutes.occasions, page: () => const OccasionsScreen()),
    GetPage(
        name: HRoutes.createOccasions,
        page: () => const CreateOccasionsScreen()), // create Occasions
    GetPage(
        name: HRoutes.editOccasions,
        page: () => const EditOccasionsScreen()), // edit Occasions

    // Products

    GetPage(name: HRoutes.products, page: () => const ProductsScreen()),
    GetPage(
        name: HRoutes.createProducts,
        page: () => const CreateProductsScreen()), // create Products
    GetPage(
        name: HRoutes.editProducts,
        page: () => const EditProductsScreen()), // edit Products

    // Orders
    GetPage(name: HRoutes.orders, page: () => const OrdersScreen()),
  ];
}
