import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/hive_boxes.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/screens/contributor_search_screen.dart';
import 'package:campuscollaborate/services/project_services.dart';
import 'package:campuscollaborate/services/user_details_services.dart';
import 'package:campuscollaborate/services/user_services.dart';
import 'package:flutter/material.dart';

import '../services/user_provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getDetails();
    super.initState();
  }
  final UserServices userServices=UserServices();
  void getDetails()async
  {
    final bool loggedIn=await GetUserDetailsServices.userLoggedIn();
    final ProjectServices projectServices = ProjectServices();
    if(loggedIn==false)
    {
      navigationService.pushScreen(Routes.loginScreen);
    }
    else
    {
      token= await GetUserDetailsServices.accessToken();
      await userServices.getCurrentUserDetails(context);
      await projectServices.getAllProjects(context);
      navigationService.pushScreen(Routes.navBarScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      body: Center(
        child: Text('Fetching Data, Please wait...'),
      ),
    ),);
  }
}
