// otp_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/auth/controller/otp_verification_controller.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments['email'];
    final isForgetPassword = Get.arguments['isForgetPassword'];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Center(
                child: Image.asset(
                  ImagePath.smallLogo,
                  width: 71.w,
                  height: 48.h,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: headingText(text: "OTP Verification"),
              ),
              SizedBox(height: 4),
              Center(
                child: smallText(
                  text: "Enter the 4-digit code sent to your email\n$email",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  color: AppColors.grayColor,
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _buildOtpTextField(index),
                ),
              ),

              SizedBox(height: 20.h),

              // Resend OTP
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => controller.resendOtp(),
                  child: Text(
                    "Resend OTP",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Verify Button
              Obx(
                () => controller.isOTPLoading.value
                    ? btnLoading()
                    : CustomButton(
                        onTap: () => controller.verifyOTP(
                            email, controller.otp.value, isForgetPassword),
                        title: Text(
                          "Verify",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        color: AppColors.primaryColor,
                      ),
              ),

              const Spacer(),

              // Bottom Section
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     SizedBox(height: 15.h),
              //     SizedBox(height: 5.h),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         smallText(
              //           text:
              //               "By continuing, you confirm that you are 18 years or older ",
              //         ),
              //         smallText(
              //           text:
              //               "and agree to our Terms & Conditions and Privacy Policy.",
              //           color: AppColors.primaryColor,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         smallText(text: "Didn't receive code? "),
              //         GestureDetector(
              //           onTap: () => controller.resendOtp(),
              //           child: smallText(
              //             text: "Resend",
              //             color: AppColors.primaryColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(height: 10.h),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpTextField(int index) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => controller.onOtpChanged(value, index),
      ),
    );
  }
}
