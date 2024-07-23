import 'package:aspen_travelle/app_config/common_classes/app_text.dart';
import 'package:aspen_travelle/app_utils/app_colors.dart';
import 'package:aspen_travelle/app_utils/app_string.dart';
import 'package:aspen_travelle/onboarding/presention/loginPage.dart';
import 'package:aspen_travelle/onboarding/presention/register.dart';

import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 12,
            ),
            Expanded(child: Image.asset("assets/images/welcome.png")),

            AppText(
              AppStrings.discoverYourText,
              color: AppColors.blueColor,
              weight: FontWeight.w600,
              fontSize: 35,
            ),
            AppText(
              AppStrings.dreamJob,
              color: AppColors.blueColor,
              weight: FontWeight.w600,
              fontSize: 35,
            ),
            const SizedBox(
              height: 15,
            ),
            AppText(
              AppStrings.exploreAllTheExistingJobText,
              weight: FontWeight.w400,
              fontSize: 14,
              textAlign:TextAlign.center,
              color: AppColors.blackColor,
            ),

            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: AppColors.blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: AppText(
                          AppStrings.loginText,
                          color: AppColors.whiteColor,
                          weight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0.2,
                          backgroundColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: AppText(
                          AppStrings.registerText,
                          color: AppColors.blackColor,
                          weight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
