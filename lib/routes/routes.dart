class HRoutes {
  static const String root = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  // banners
  static const String banners = '/banners';
  static const String createBanner = '/create-banner';
  static const String editBanner = '/edit-banner';
  // categories
  static const String categories = '/categories';
  static const String createCategories = '/create-categories';
  static const String editCategories = '/edit-categories';
  // Occasions
  static const String occasions = '/occasions';
  static const String createOccasions = '/create-occasions';
  static const String editOccasions = '/edit-occasions';

  // products
  static const String products = '/products';
  static const String createProducts = '/create-products';
  static const String editProducts = '/edit-products';

  static const String orders = '/orders';
  static const List sideMenuItems = [
    dashboard,
    banners,
    categories,
    products,
    orders,
    // login,
    // createBanner,
    // editBanner,
    // root,
  ];
}
