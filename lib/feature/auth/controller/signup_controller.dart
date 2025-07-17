import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/core/services_class/local_data.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import '../../../core/network_caller/endpoints.dart';

class SignupController extends GetxController {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController nameTEController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  String? fcmToken;
  final NetworkConfig _networkConfig = NetworkConfig();

  @override
  void onInit() {
    super.onInit();
  }

  final isLoginLoading = false.obs;

  Future<bool> signIn() async {
    isLoginLoading.value = true;

    if (emailTEController.text.isEmpty || passwordTEController.text.isEmpty) {
      AppSnackbar.show(message: 'Please fill all fields', isSuccess: false);
      return false;
    }
    try {
      String email = emailTEController.text;
      String password = passwordTEController.text;
      String fullName = nameTEController.text;

      final Map<String, dynamic> requestBody = {
        "fullName": fullName,
        "email": email,
        "fcmToken": "etgarhstjasthaerhaf",
        "password": password,
        "role": "USER"
      };

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.signUp,
        json.encode(requestBody),
        is_auth: false,
      );
      if (response != null && response['success'] == true) {
        Get.to(OtpVerificationScreen(),
            arguments: {'email': email, 'isForgetPassword': false});

        //    Get.to(OtpVerificationScreen(), arguments: {'email': email});
        AppSnackbar.show(message: "Registration Successful", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: response['message'], isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
      return false;
    } finally {
      isLoginLoading.value = false;
    }
  }

  void setUpValues() {
    emailTEController.text = "super.admin@gmail.com";
    passwordTEController.text = "12345678";
  }
}
