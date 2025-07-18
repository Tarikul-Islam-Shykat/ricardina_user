import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/core/services_class/local_data.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/user_dashboard/ui/user_dashboard.dart';
import '../../../core/network_caller/endpoints.dart';

class ForgetPaswordController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();
  final TextEditingController emailTEController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  final isForgetPasswordLoading = false.obs;
  Future<bool> forgetPassword() async {
    try {
      isForgetPasswordLoading.value = true;
      final Map<String, dynamic> requestBody = {
        "email": emailTEController.text
      };

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.forgotPass,
        json.encode(requestBody),
        is_auth: false,
      );
      if (response != null && response['success'] == true) {
        Get.to(OtpVerificationScreen(), arguments: {
          'email': emailTEController.text,
          'isForgetPassword': true
        });

        AppSnackbar.show(
            message: "An OTP was sent to your email", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: response['message'], isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
      return false;
    } finally {
      isForgetPasswordLoading.value = false;
    }
  }
}
