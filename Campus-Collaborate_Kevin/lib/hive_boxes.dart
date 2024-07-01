import 'package:hive/hive.dart';

import 'models/user_info.dart';

late Box<UserInfo> userInfoBox;

late Box<String> accessTokenBox;

late Box<bool> loggedInBox;

const String accessTokenKey='access-token-key';

const String loggedInKey='logged-in';