import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:usman_hameed/data_provider/auth_provider.dart';
import 'package:usman_hameed/utils.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider=Provider.of<AuthProvider>(Get.context!,listen: false);
    authProvider.sendOtp();


  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (BuildContext context, data, Widget? child) {
          return SafeArea(
              child: Scaffold(
                body: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * .13,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            "A Verification code has been sent to",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: Get.width * .05,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            data.phone,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width * .05),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .15,
                        ),
                        OtpTextField(
                          cursorColor: Colors.transparent,
                          numberOfFields: 6,
                          borderColor: const Color(0xFF512DA8),
                          showFieldAsBox: false,
                          onCodeChanged: (String code) {},
                          onSubmit: (String verificationCode) {

                            data.verifyPhone(verificationCode);



                          }, // end onSubmit
                        ),
                        SizedBox(
                          height: Get.height * .15,
                        ),
                        customButton()
                      ],
                    ),
                  ),
                ),
              ),
            );
        });
  }
}
