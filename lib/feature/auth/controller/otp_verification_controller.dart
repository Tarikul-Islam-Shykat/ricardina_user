// otp_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';
import 'package:prettyrini/feature/auth/screen/reset_password.dart';

class OtpController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  RxString otp = ''.obs;

  void updateOtp() {
    String currentOtp = '';
    for (var controller in otpControllers) {
      currentOtp += controller.text;
    }
    otp.value = currentOtp;
    print('Updated OTP: ${otp.value}');
  }

  var isOTPLoading = false.obs;
  Future<bool> verifyOTP(
      String email, String otp, bool isForgetPassword) async {
    isOTPLoading.value = true;

    try {
      final Map<String, dynamic> requestBody = {
        "email": email,
        "otp": int.parse(otp)
      };

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.verifyOTP,
        json.encode(requestBody),
        is_auth: false,
      );
      if (response != null && response['success'] == true) {
        if (isForgetPassword == true) {
          Get.to(ResetPasswordScreen(), arguments: {'email': email});
        } else {
          Get.to(LoginScreen());
        }
        AppSnackbar.show(
            message: "OTP Verification Successful", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: "Failed To Verify OTP", isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
      return false;
    } finally {
      isOTPLoading.value = false;
    }
  }

  void onOtpChanged(String value, int index) {
    updateOtp();

    // Auto focus to next field when this field is filled
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
    }
    // Auto focus to previous field when this field is empty
    else if (value.isEmpty && index > 0) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index - 1]);
    }
  }

  void resendOtp() {
    print('Resending OTP...');
    // Add your resend OTP logic here
  }

  void verifyOtp() {
    if (otp.value.length == 4) {
      print('Verifying OTP: ${otp.value}');
      // Add your OTP verification logic here
    } else {
      Get.snackbar('Error', 'Please enter complete OTP');
    }
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
