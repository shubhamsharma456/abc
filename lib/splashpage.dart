import 'dart:async';

import 'package:aspen_travelle/app_utils/app_colors.dart';
import 'package:aspen_travelle/app_utils/app_string.dart';
import 'package:aspen_travelle/onboarding/presention/onBoardingPage.dart';
import 'package:flutter/material.dart';

import 'app_config/common_classes/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,

      decoration: const BoxDecoration(

        image: DecorationImage(
          image: AssetImage("assets/images/splashimage.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Padding(
            padding: const EdgeInsets.all(50)+const EdgeInsets.only(top: 50),
            child: Image.asset("assets/images/aspen.png"),
          ),
          const Spacer(),
          // const Text("Plain Your Luxurious Vacations ",style: TextStyle(color: Colors.white,fontSize: 27),),
       DefaultTextStyle(
            style: const TextStyle(color: AppColors.whiteColor, fontSize: 24),
            child: AppText(AppStrings.planYourText),
          ),
    DefaultTextStyle(
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 40,
                fontWeight: FontWeight.w500),
            child: AppText(AppStrings.luxuriousText),
          ),
          DefaultTextStyle(
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 40,
                fontWeight: FontWeight.w500),
            child: AppText(AppStrings.vacationText),
          )
        ],
      ) /* add child content here */,
    );
  }
}
