import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:usman_hameed/data_provider/dashboard_provider.dart';
import 'package:usman_hameed/screens/splash_screen.dart';
import 'data_provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext ctx) {
          return AuthProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (BuildContext ctx) {
          return DashBoardProvider();
        },
      ),
    ],
    child: const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  ));
}
