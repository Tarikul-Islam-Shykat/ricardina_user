import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/auth/screen/sign_up_screen.dart';
import 'package:prettyrini/feature/common_page/ui/health_ui.dart';
import 'package:prettyrini/feature/medical_tab/ui/medical_tabs_ui.dart';
import 'package:prettyrini/feature/profile/ui/edit_profile_screen.dart';
import 'package:prettyrini/route/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/const/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configEasyLoading();
  await SharedPreferences.getInstance();
  Get.put(ThemeController());
  runApp(const MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.grayColor
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foot Fitness',
        getPages: AppRoute.routes,
        initialRoute: AppRoute.splashScreen,
        // home: EditProfile(),
        builder: EasyLoading.init(),

        // home: MedicalScreenTab(),

        // home: SplashScreen(),
        // home: LoginScreen(),
        // home: ResetPasswordScreen(),
        // home: ForgetPasswordScreen(),
        // home: WelcomeScreen(),
        //   home: NotificationScreen(),
        // home: ProfileScreen(),
        //   home: EditProfile(),
        //  home : ChangePassoword()
        // home: HealthCardsScreen(),
        //    home: MedicationPage(),
        // home: MedicineReminderPage(),
        //    home: CommonStatusUi(),
        // home: WeeklyReportsPage(),
        // home: DoctorDetailsPage(),
        //  home: BasicPlanTips(),
        // home: IntermediateTipsUi(),
      ),
    );
  }
}
