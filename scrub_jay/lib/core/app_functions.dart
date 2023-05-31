import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';

String? formValidation(String? text, String type, [int? min, int? max]) {
  if (text == null || text.isEmpty) {
    return 'this field is required'.tr;
  } else {
    if (type == 'username') {
      var reg = RegExp(r"^(?:\p{L}\p{Mn}*|)+$", unicode: true);
      text = text.replaceAll(' ', '');
      if (!reg.hasMatch(text)) {
        return 'not valid name'.tr;
      }
    } else if (type == 'email') {
      if (!isEmail(text)) {
        return 'not valid email'.tr;
      }
    } else if (type == 'phone') {
      if (!isNumeric(text)) {
        return 'not valid phone number'.tr;
      } else if (!text.startsWith('05')) {
        return 'must start with 05'.tr;
      }
      if (text.length < 10) {
        return 'must be 10 digits'.tr;
      }
    }
    if (min != null) {
      if (text.length < min) {
        return '${'must be more than'.tr} $min ${min > 10 ? 'character'.tr : 'characters'.tr}';
      }
    }
    if (max != null) {
      if (text.length > max) {
        return '${'must be less than'.tr} $max ${max > 10 ? 'character'.tr : 'characters'.tr}';
      }
    }
  }
  return null;
}

void getxSnackbar(String title, String message, {Color? backgroundColor}) {
  Get.snackbar(
    '',
    '',
    backgroundColor: backgroundColor ?? Get.theme.colorScheme.error,
    colorText: Colors.white,
    titleText: Text(
      title.tr,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message.trim().tr.capitalizeFirst.toString(),
      style: TextStyle(
        fontSize: 15.sp,
        color: Colors.white,
      ),
    ),
  );
}
