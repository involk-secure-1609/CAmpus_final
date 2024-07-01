import 'package:campuscollaborate/hive_boxes.dart';

class GetUserDetailsServices{
  static Future<String> accessToken()async{
    final String? accessToken=accessTokenBox.get(accessTokenKey);
    if(accessToken==null){
      throw ('Error, No token found');
    }
    return accessToken;
  }

  static Future<bool> userLoggedIn()async{
    final bool? isLoggedIn=loggedInBox.get(loggedInKey);
    if(isLoggedIn==null){
      return false;
    }
    return isLoggedIn;
  }
}