//65BC6037-A88A-432A-97F7-8726E21265C9
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usman_hameed/data_provider/dashboard_provider.dart';
import '../utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// var googleGeocoding = GoogleGeocoding("AIzaSyA5OUiHLLzc_ksjrvw3nrpdO77B4U75Dzk");
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
class AuthProvider extends ChangeNotifier {

  String name = '';
  String phone = '';
  String otpPin = '';
  String address = "";
  String verificationId = "";
  String picLInk="";


  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  final ImagePicker picker = ImagePicker();
  XFile? image;



  void sendOtp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        logger.wtf("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException error) {},
    );
  }

 void  verifyPhone(String verificationCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: verificationCode);
String picLink;
    auth.signInWithCredential(credential).catchError((error, stackTrace) {
      logger.wtf("NOT OK");
      logger.e(error);
    }).whenComplete(() async{
      logger.wtf("OK");


      firebaseStorage.Reference ref =
      firebaseStorage.FirebaseStorage.instance.ref(phone);
      ref.putFile(File(image!.path));
      





      await createUsers();
      await localStorage.write(keyName, name);
      await localStorage.write(keyPhone, phone);
      await localStorage.write(keyAddress, address);
     // await localStorage.write(keyImageLink, picLink);
     // Get.to(() => DashBoard());
    });
  }

  void convertLatLogToAddress(lat, lng) async {
    List<Address> address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(lat, lng));
    logger.e(address.first.addressLine!);
    this.address = address.first.addressLine;
    notifyListeners();
  }

  /// fireStore

  Future<void> createUsers() async {






    Map<String, dynamic> data = {
      'status': false,
      'fullName': name,
      'phone': phone,
      'address': address,
      'imageLink': address,

    };
    await collection
        .doc(phone)
        .set(data)
        .then((value) => logger.e('user added'));
  }



  /// bottomSheet for image Picker
  Future bottomBar() {
    return Get.bottomSheet(Container(
      height: Get.height * .15,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customButton(
                buttonText: "Open Camera",
                onTap: () async {
                  image = await picker.pickImage(source: ImageSource.camera);
                  notifyListeners();

                }),
            customButton(
                buttonText: "upload from gallery",
                onTap: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  notifyListeners();
                }),
          ],
        ),
      ),
    ));
  }
}
