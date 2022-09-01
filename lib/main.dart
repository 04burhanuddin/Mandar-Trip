import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';
import 'package:mandar_trip/app/themes/theme.dart';
import 'app/controllers/theme_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final ThemesController themeController = Get.put(ThemesController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GetMaterialApp(
          // ? final textScale = MediaQuery.of(context).textScaleFactor;
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 0.80),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          title: 'Mandar Trip',
          themeMode: getThemeMode(themeController.theme),
          initialRoute: snapshot.data != null ? Routes.DASHBOARD : Routes.ONBOARDING,
          getPages: AppPages.routes,
        );
      },
    );
  }

  ThemeMode getThemeMode(String type) {
    ThemeMode themeMode = ThemeMode.system;
    switch (type) {
      case "Sistem":
        themeMode = ThemeMode.system;
        break;
      case "Gelap":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
    return themeMode;
  }
}
