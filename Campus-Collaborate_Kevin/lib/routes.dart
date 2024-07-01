
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/models/comment_model.dart';
import 'package:campuscollaborate/models/project.dart';
import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/screens/bottom_nav_bar_screen.dart';
import 'package:campuscollaborate/screens/contributor_search_screen.dart';
import 'package:campuscollaborate/screens/course_review_comments.dart';
import 'package:campuscollaborate/screens/course_review_screen.dart';
import 'package:campuscollaborate/screens/create_project_screen.dart';
import 'package:campuscollaborate/screens/home_screen.dart';
import 'package:campuscollaborate/screens/login_screen.dart';
import 'package:campuscollaborate/screens/new_course_review_screen.dart';
import 'package:campuscollaborate/screens/other_user_profile_screen.dart';
import 'package:campuscollaborate/screens/profile_screen.dart';
import 'package:campuscollaborate/screens/project_list_screen.dart';
import 'package:campuscollaborate/screens/project_screen.dart';
import 'package:campuscollaborate/screens/splash_screen.dart';
import 'package:campuscollaborate/screens/synergy_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splashScreen:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case Routes.profileScreen:
      final userInfo = settings.arguments as UserInfo;
      return MaterialPageRoute(
          builder: (context) => ProfileScreen(userInfo: userInfo));
    case Routes.createProjectScreen:
      return MaterialPageRoute(builder: (context)=>const CreateProjectScreen());
    case Routes.projectScreen:
      final project=settings.arguments as Project;
      return MaterialPageRoute(builder: (context)=>ProjectScreen(project: project));
    case Routes.homeScreen:
      final userInfo=settings.arguments as UserInfo;
      return MaterialPageRoute(builder: (context)=>HomeScreen(userInfo: userInfo));
    case Routes.navBarScreen:
      return MaterialPageRoute(builder: (context)=>const NavBarScreen());
    case Routes.loginScreen:
      return MaterialPageRoute(builder: (context)=>const LoginScreen());
    case Routes.contributorSearchScreen:
      return MaterialPageRoute(builder: (context)=>const ContributorSearchScreen());
    case Routes.projectListScreen:
      final projects = settings.arguments as List<Project>?;
      return MaterialPageRoute(builder: (context)=> ProjectListScreen(project: projects));
    case Routes.savedProjectListScreen:
      final projects = settings.arguments as List<Project>?;
      return MaterialPageRoute(builder: (context)=>SavedProjectListScreen(project: projects));
    case Routes.otherUserProfileScreen:
      final userInfo = settings.arguments as UserInfo;
      return MaterialPageRoute(builder: (context)=>OtherUserProfileScreen(userInfo: userInfo));
    case Routes.otherUserProfileSplashScreen:
      final id = settings.arguments as String;
      return MaterialPageRoute(builder: (context)=>ProfileScreenSplash(userId: id));
    case Routes.createCourseReviewScreen:
      return MaterialPageRoute(builder: (context)=>NewCourseReviewScreen());
    case Routes.createCourseReviewScreen:
      return MaterialPageRoute(builder: (context)=>CourseReviewScreen());
    case Routes.viewCourseReviewCommentsScreen:
      final comment=settings.arguments as CourseReviewComment;
      return MaterialPageRoute(builder: (context)=>CourseReviewComments(comment: comment,));
    case Routes.synergyScreen:
      return MaterialPageRoute(builder: (context)=>SynergyScreen());
    default:
      return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Invalid Screen'),
    );
  }
}
