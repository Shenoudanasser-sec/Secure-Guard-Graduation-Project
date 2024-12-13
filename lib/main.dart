import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_flutter_app/firebase_options.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';
import 'app.dart';

/// ------ For Docs & Updates Check ------
/// ------------- README.md --------------

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // -- Initialize GetStorage
  await GetStorage.init();

  // -- Preserve splash screen until initialization is done
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // -- Initialize Firebase if not initialized already
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'login_flutter_app',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // -- Initialize Authentication Repository and inject it using GetX
  Get.put(AuthenticationRepository());

  // -- Run the app
  runApp(const App());
}
