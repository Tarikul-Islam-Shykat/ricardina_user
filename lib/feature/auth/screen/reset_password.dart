import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/auth/controller/reset_password_controller.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());
  ResetPasswordScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments['email'];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50.h),
            Center(
                child: Image.asset(
              ImagePath.smallLogo,
              width: 71.w,
              height: 48.h,
              fit: BoxFit.fill,
            )),
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: headingText(
              text: "Reset Password",
            )),
            SizedBox(
              height: 4,
            ),
            Center(
                child: smallText(
                    text:
                        "Please check your email. Give correct reset 5 digit code here.",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    color: AppColors.grayColor)),
            SizedBox(
              height: 20.h,
            ),
            normalText(
              text: 'New Password',
            ),
            CustomAuthField(
              keyboardType: TextInputType.visiblePassword,
              radiusValue2: 15,
              radiusValue: 15,
              controller: passwordController,
              hintText: "New Password",
            ),
            SizedBox(height: 10.h),
            normalText(
              text: 'Confirm Password',
            ),
            CustomAuthField(
              keyboardType: TextInputType.visiblePassword,
              radiusValue2: 15,
              radiusValue: 15,
              controller: resetPasswordController.confirmPassword,
              hintText: "Confirm Password",
            ),
            Spacer(),
            Obx(
              () => resetPasswordController.isResetPassswordLoading.value
                  ? btnLoading()
                  : CustomButton(
                      onTap: () {
                        resetPasswordController.resetPassword(email);
                      },
                      title: Text(
                        "Reset Password",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      color: AppColors.primaryColor,
                    ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
