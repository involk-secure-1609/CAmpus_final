import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/hive_boxes.dart';
import 'package:campuscollaborate/models/admin.dart';
import 'package:campuscollaborate/models/project.dart';
import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/services/all_project_providers.dart';
import 'package:campuscollaborate/services/contributor_search_screen_service.dart';
import 'package:campuscollaborate/services/docs_and_images.dart';
import 'package:campuscollaborate/services/drop_down_services.dart';
import 'package:campuscollaborate/services/nav_bar_services.dart';
import 'package:campuscollaborate/services/toggle_button_services.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:campuscollaborate/routes.dart' as router;
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdminAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(UserInfoAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  userInfoBox = await Hive.openBox('user-info');
  accessTokenBox = await Hive.openBox('access-token');
  loggedInBox = await Hive.openBox('logged-in-box');
  // await Firebase.initializeApp(
  //     name: 'campus-collab',
  //     options: DefaultFirebaseOptions.currentPlatform,
  //     );
  setUpLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavBarService()),
      ChangeNotifierProvider(create: (_) => DropDownServices()),
      ChangeNotifierProvider(create: (_) => ProjectStatusToggleButtonService()),
      ChangeNotifierProvider(create: (_) => ProjectTypeToggleButtonService()),
      ChangeNotifierProvider(create: (_) => DocsStateService()),
      ChangeNotifierProvider(create: (_) => ProjectImageStateService()),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(create: (_)=>AllProjectsProvider(),),
      ChangeNotifierProvider(create: (_)=>ContributorSearchScreenService())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: "/",
      theme: Themes.theme,
      onGenerateInitialRoutes: (String initialName) {
        return [router.generateRoute(const RouteSettings(name: "/"))];
      },
    );
  }
}
