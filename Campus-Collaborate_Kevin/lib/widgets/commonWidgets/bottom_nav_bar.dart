import 'package:campuscollaborate/chats/dmchats.dart';
import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/screens/course_review_screen.dart';
import 'package:campuscollaborate/screens/home_screen.dart';
import 'package:campuscollaborate/screens/new_course_review_screen.dart';
import 'package:campuscollaborate/screens/synergy_screen.dart';
import 'package:campuscollaborate/screens/test_screen.dart';
import 'package:campuscollaborate/services/all_project_providers.dart';
import 'package:campuscollaborate/services/nav_bar_services.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
    PersistentTabController(initialIndex: 0);
    return Consumer<NavBarService>(builder: (context, navBarService, child) {
      return PersistentTabView(
        context,
        backgroundColor: Colors.black, // Changed background color to black
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(15.0),
          colorBehindNavBar: Colors.black,
        ),
        navBarHeight: 65,
        navBarStyle: NavBarStyle.style9, // Kept the visually appealing style
        items: [
          PersistentBottomNavBarItem(
            icon: Image.asset(
              'assets/home.png',
              width: 32,
              color: Colors.white, // Changed icon color to white
            ),
            title: ("Home"), // Added title for the icon
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white, // Changed text color to white
            ),
            activeColorPrimary: Colors.orange,
            activeColorSecondary: Colors.orangeAccent,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(
              'assets/course_review.png',
              width: 32,
              color: Colors.white, // Changed icon color to white
            ),
            title: ("Reviews"), // Added title for the icon
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white, // Changed text color to white
            ),
            activeColorPrimary: Colors.orange,
            activeColorSecondary: Colors.orangeAccent,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(
              'assets/hand_shake.png',
              width: 32,
              color: Colors.white, // Changed icon color to white
            ),
            title: ("Connect"), // Added title for the icon
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white, // Changed text color to white
            ),
            activeColorPrimary: Colors.orange,
            activeColorSecondary: Colors.orangeAccent,
            inactiveColorPrimary: Colors.white54,
          ),
        ],
        controller: controller,
        screens: [
          HomeScreen(
            userInfo: context.read<UserProvider>().userInfo,
            project: context.read<AllProjectsProvider>().allProjects,
          ),
          const CourseReviewScreen(),
          const SynergyScreen(),
        ],
      );
    });
  }
}
