import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usman_hameed/screens/authScreens/create_account.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {

      Get.to(()=>const CreateUserScreen());

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.white,
            child: Center(
              child: Image.asset("assets/splashLogo.png"),
            )));
  }
}
