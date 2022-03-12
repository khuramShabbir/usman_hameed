import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:usman_hameed/data_provider/auth_provider.dart';
import 'package:usman_hameed/screens/authScreens/otp_verification_screen.dart';
import 'package:usman_hameed/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return Consumer<AuthProvider>(
            builder: (BuildContext ctx, data, Widget? cld) => Scaffold(

              body: Container(
                width: Get.width,
                color: backGroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customInputFormField(
                        isOutlinedBorder: true,
                        hintText: "Name",
                        onChange: (v) {
                          data.name = v;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customInputFormField(
                          keyboardType: TextInputType.phone,
                          hintText: "Phone",
                          isOutlinedBorder: true,
                          onChange: (v) {
                            data.phone = v;
                          }),
                      const SizedBox(
                        height: 20,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      customButton(buttonText: "Login",onTap: (){
                        Get.to(()=>const OtpVerification());


                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Not Registered Yet?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
