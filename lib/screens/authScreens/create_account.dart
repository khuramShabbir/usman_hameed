import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:usman_hameed/data_provider/auth_provider.dart';
import 'package:usman_hameed/screens/authScreens/login_screen.dart';
import 'package:usman_hameed/screens/authScreens/otp_verification_screen.dart';
import 'package:usman_hameed/screens/authScreens/google_map.dart';
import 'package:usman_hameed/utils.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (BuildContext ctx, data, Widget? cld) => Scaffold(
              body: Container(
                width: Get.width,
                color: backGroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atta Application",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 30),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () async {
                              await data.bottomBar();
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(color: Colors.grey,
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(data.image!=null?data.image!.path:''))

                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(),
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
                      customInputFormField(
                        textEditingController:
                            TextEditingController(text: data.address),
                        suffixIcon: InkWell(
                            onTap: () async {
                              var location =
                                  await Get.to(() => GoogleMapScreen());
                              if (location == null) return;

                              data.convertLatLogToAddress(
                                  location[0], location[1]);
                            },
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                        isOutlinedBorder: true,
                        hintText: "Address",
                        onChange: (v) {
                          data.address = v;
                        },
                      ),
                      const SizedBox(height: 20),
                      customButton(
                          buttonText: "SignUp",
                          onTap: () async {
                            if (data.phone.isEmpty ||
                                data.phone.length < 13 ||
                                data.phone.length > 13 ||
                                data.name.isEmpty ||
                                data.address.isEmpty) {
                              showToast("Invalid Information");
                              return;
                            }

                            Get.to(() => OtpVerification());

                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: const Text(
                              "login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
