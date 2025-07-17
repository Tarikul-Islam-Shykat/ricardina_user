import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/auth/controller/signup_controller.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset:
          false, // This prevents the screen from resizing when keyboard appears
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
              )),
              SizedBox(
                height: 10,
              ),
              Center(
                child: headingText(text: "Sign In Account"),
              ),
              SizedBox(
                height: 4,
              ),
              Center(
                  child: smallText(
                      text:
                          "Start your journey in playmate with fun, interactive lessons now",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      color: AppColors.grayColor)),
              SizedBox(
                height: 15.h,
              ),
              normalText(
                text: 'Full name',
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomAuthField(
                radiusValue2: 15,
                radiusValue: 15,
                controller: controller.nameTEController,
                hintText: "Enter Full Name",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15.h,
              ),
              normalText(
                text: 'Email',
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomAuthField(
                radiusValue2: 15,
                radiusValue: 15,
                controller: controller.emailTEController,
                hintText: "Enter Email Here",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15.h,
              ),
              normalText(
                text: 'Password',
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomAuthField(
                radiusValue2: 15,
                radiusValue: 15,
                obscureText: true,
                controller: controller.passwordTEController,
                hintText: "Enter Password Here",
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 5.h,
              ),

              SizedBox(
                height: 30,
              ),
              Obx(
                () => controller.isLoginLoading.value
                    ? btnLoading()
                    : CustomButton(
                        onTap: controller.signIn,
                        title: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        color: AppColors.primaryColor,
                      ),
              ),

              const Spacer(), // This pushes the button section to the bottom
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallText(text: "Already Have An Account ?"),
                      GestureDetector(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: smallText(
                              text: " Log in", color: AppColors.primaryColor))
                    ],
                  ),
                  // Center(child: authTerms(context)),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
