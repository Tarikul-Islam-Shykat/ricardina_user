import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/profile/widget/profile_image_text.dart';
import 'package:prettyrini/feature/profile/widget/profile_list_tile.dart';
import 'package:prettyrini/route/route.dart';

import '../../../core/const/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Profile",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.blackColor),
            )),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Color(0xFFFFFFFF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile pic
                  Container(
                    height: 55.h,
                    width: 64.w,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.purple.shade50.withValues(alpha: .5),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          ImagePath.profile,
                        )),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      SizedBox(
                        width: 240.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Darrell Steward",
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor),
                            ),
                            // InkWell(
                            //     onTap: () =>
                            //         Get.toNamed(AppRoute.editProfileScreen),
                            //     child: Image.asset(ImagePath.editIcon)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      profileEmailText(
                        Icons.email,
                        'darrellsteward@example.com',
                      ),
                      profileEmailText(
                        Icons.phone,
                        '+1 761 234 5678',
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Support & Help",
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileListTile(
                    Icons.book,
                    'About Us',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                      Icons.password_outlined, 'Change Password', () {}),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.terminal,
                    'Terms & Conditions',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.privacy_tip,
                    'Privacy Policy',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.login,
                    'Log Out',
                    () async {
                      Get.toNamed(AppRoute.loginScreen);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
