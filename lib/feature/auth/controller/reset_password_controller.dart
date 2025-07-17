import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';
import '../../../core/network_caller/endpoints.dart';

class ResetPasswordController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  final isResetPassswordLoading = false.obs;
  Future<bool> resetPassword(String email) async {
    try {
      isResetPassswordLoading.value = true;
      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": confirmPassword.text
      };

      log(confirmPassword.text);
      log(email);

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.resetPassword,
        json.encode(requestBody),
        is_auth: false,
      );
      if (response != null && response['success'] == true) {
        Get.to(LoginScreen());
        // Get.to(OtpVerificationScreen(), arguments: {
        //   'email': emailTEController.text,
        //   'isForgetPassword': true
        // });

        AppSnackbar.show(
            message: "Password Changed Successfully", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: response['message'], isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
      return false;
    } finally {
      isResetPassswordLoading.value = false;
    }
  }
}
