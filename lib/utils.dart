import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color backGroundColor = Colors.white;
Logger logger = Logger();

Widget customInputFormField({
  bool obscure = false,
  var keyboardType,
  var onChange,
  var suffixIcon,
  var controlller,
  var prefixIconList,
  String? hintText,
  double fontSize = 16,
  var autoValidateMode,
  String? errorText,
  var validator,
  TextEditingController? textEditingController,
  var textColor = Colors.grey,
  bool isOutlinedBorder = false,
  String? initialValue
}) {
  return TextFormField(
    initialValue:initialValue,
    autovalidateMode: autoValidateMode,
    controller: textEditingController,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscure,
    onChanged: onChange,

    decoration: InputDecoration(
      disabledBorder: InputBorder.none,
      border: isOutlinedBorder
          ? OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          : null,
      prefixIcon: prefixIconList,
      suffix: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: fontSize,
        color: Colors.grey,
      ),
    ),
  );
}

Widget customButton({
  String buttonText = "Next",
  onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Text(
          "   " + buttonText + "   ",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    ),
  );
}


Future showToast(String msg)async{
  return await Fluttertoast.showToast(
      msg:"  "+msg+"  ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );

}