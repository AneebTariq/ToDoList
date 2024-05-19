import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/utils/app_colors.dart';
import '../../config/utils/image_assets.dart';
import '../../data/sharepref/shareprefrence.dart';
import '../home/home_screen.dart';
import 'Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _checkSessionAndProceed() async {
    bool status = await SharedPrefClient().isUserLoggedIn();

    Timer(const Duration(seconds: 3), () {
      if (status) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  LoginScreen()));
        // Get.offAll(() => const DonorLogin());
      }
    });
  }

  @override
  void initState()  {
    _checkSessionAndProceed();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(ImageAssets.splashIcon,
                  height: 200.h,
                  width: 200.w,
                ))),
      ),
    );
  }
}
