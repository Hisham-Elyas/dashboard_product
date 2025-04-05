import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';
import 'data/repositories/auth/auth_repo.dart';
import 'firebase_options.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage
  GetStorage.init();

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) {
    // Initialize Auth Repository
    Get.put(AuthRepo());
  });
  // Main App Starts here...
  runApp(const App());
}
