import 'package:aspen_travelle/app_utils/app_string.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app_config/common_classes/app_text.dart';
import '../../../../app_utils/app_colors.dart';
import '../../../view_modle/dashboard_view_modle.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}




class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(dashboardStateProvider.notifier).initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardStateProvider);
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        getHeaderPart(dashboardState),
        getActivitiesPart(dashboardState),
        getPopularLisPart(dashboardState),
        getRecommendedLisPart(dashboardState),


      ]),
    );
  }








  Widget getHeaderPart(DashBoardState dashboardState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                AppText(
                  AppStrings.exploreText,
                  fontSize: 14,
                  weight: FontWeight.w400,
                  color: AppColors.dmBlackColor,
                ),
                const Spacer(),
                Image.asset('assets/images/location.png')
              ],
            ),
          ),
          AppText(
            AppStrings.aspenText,
            fontSize: 32,
            weight: FontWeight.w500,
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGreyColor,
                  fontSize: 13),
              prefixIcon: SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svg/search.svg",
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.lightBlueColor, width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: AppStrings.findThingsToDoText,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.lightBlueColor, width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColors.lightBlueColor, width: 32.0),
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        ],
      ),
    );
  }
  Widget getActivitiesPart(DashBoardState dashboardState) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28,horizontal: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dashboardState.activities?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                      onTap: () {
                        ref
                            .read(dashboardStateProvider.notifier)
                            .getIndex(index);
                      },
                      child: Container(
                        height: 41,
                        width: 89,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: dashboardState.selectedIndex == index
                                ? AppColors.lightBlueColor
                                : AppColors.whiteColor),
                        child: Center(
                          child: Text(dashboardState.activities?[index] ?? '',
                              style: TextStyle(
                                  color: dashboardState.selectedIndex == index
                                      ? Colors.blue
                                      : AppColors.lightGreyColor,
                                  fontWeight:
                                  dashboardState.selectedIndex == index
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontSize: 14)),
                        ),
                      )));
            }),
      ),
    );
  }

  Widget getPopularLisPart(DashBoardState dashboardState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),

          child: Row(
            children: [
              AppText(
                AppStrings.popularText,
                fontSize: 18,
                weight: FontWeight.w600,
              ),
              const Spacer(),
              AppText(
                AppStrings.seeAllText,
                fontSize: 12,
                weight: FontWeight.w500,
                color: Colors.blue,
              )
            ],
          ),
        ),

        //Popular Section

        SizedBox(
          height: 300,
          child: ListView.builder(
              shrinkWrap: true,
                   padding: const EdgeInsets.symmetric(horizontal: 20.0),

              scrollDirection: Axis.horizontal,
              itemCount: dashboardState.popular?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Stack(
                    children: [
                      Container(
                        width: 188,
                        height: 240,
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.blue,
                          image: DecorationImage(
                            image: AssetImage(
                                dashboardState.popular?[index].image ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: const Color.fromRGBO(77, 86, 82, 1)),
                          child: Text(
                            dashboardState.popular?[index].place ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 10,
                        child: Container(
                          width: 52,
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: const Color.fromRGBO(77, 86, 82, 1)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/svg/star.svg"),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    dashboardState.popular?[index].rating
                                            .toString() ??
                                        '',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Positioned(
                          bottom: 60,
                          right: 10,
                          child: SvgPicture.asset("assets/svg/heart.svg")),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget getRecommendedLisPart(DashBoardState dashboardState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),

          child: AppText(
            AppStrings.recommendedText,
            fontSize: 18,
            weight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),

              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: dashboardState.popular?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 174,
                            height: 96,
                            margin: const EdgeInsets.symmetric(vertical: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage(
                                    dashboardState.popular?[index].image ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: AppColors.whiteColor,
                              ),
                              child: Container(
                                width: 41,
                                height: 16,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color.fromRGBO(77, 86, 82, 1)),
                                child: Center(
                                  child: AppText(
                                    AppStrings.fourText,
                                    fontSize: 12,
                                    weight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppText(
                        AppStrings.exploreAspenText,
                        fontSize: 14,
                        weight: FontWeight.w500,
                        color: AppColors.dmBlackColor,
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }




}
