import 'package:flutter/material.dart';

import '../widgets/commonWidgets/bottom_nav_bar.dart';


class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
        bottomNavigationBar: BottomNavBar(),
    ));
  }
}
