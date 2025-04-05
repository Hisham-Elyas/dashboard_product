import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/auth/auth_repo.dart';
import 'routes.dart';

class HRoutesMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthRepo.instance.isAuthenticated
        ? null
        : const RouteSettings(name: HRoutes.login);
  }
}
