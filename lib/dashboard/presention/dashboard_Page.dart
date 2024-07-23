
import 'package:aspen_travelle/dashboard/presention/home/presention/api_Demo.dart';
import 'package:aspen_travelle/dashboard/presention/home/presention/homescreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';



import '../view_modle/dashboard_view_modle.dart';
import 'home/presention/homepage.dart';


class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
  HomeScreen(),
  ApiDemo(),
Center()

  ];
  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardStateProvider);

    return Scaffold(
      //Appbar with title and icons


      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/home.svg'),

                label: 'home',
                // backgroundColor: Colors.green
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/ticket.svg'),

                label: 'Ticket',
                // backgroundColor: Colors.green
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/heartbottom.svg'),
                label: 'Heart',
                activeIcon: SvgPicture.asset('assets/svg/heart_fill.svg'),
                // backgroundColor: Colors.yellow
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/profile.svg'),
                label: 'Profile',

                // backgroundColor: Colors.blue,
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: dashboardState.dashboardSelectedIndex,
            iconSize: 20,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (int index){
              ref.read(dashboardStateProvider.notifier).setIndex(index);
            },
            elevation: 5),
      ),

      body: _widgetOptions.elementAt(dashboardState.dashboardSelectedIndex),
    );
  }
}
