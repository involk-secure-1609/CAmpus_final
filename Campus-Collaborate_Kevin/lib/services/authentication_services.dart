import 'package:campuscollaborate/constants/api_end_points.dart';
import 'package:campuscollaborate/hive_boxes.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../constants/routing_constants.dart';
import '../locator.dart';

class AuthenticationServices{
  Future<void> loginAuthenticate()async{
   try{
     final result = await FlutterWebAuth.authenticate(
         url: outlookAuthenticationLogin, callbackUrlScheme: "campuscollaborate");
     final String? accessToken = Uri.parse(result).queryParameters['token'];
     if(accessToken==null)
     {
       throw ("Access Token or User not found");
     }
     await accessTokenBox.put(accessTokenKey, accessToken);
     await loggedInBox.put(loggedInKey, true);
     navigationService.pushScreen(Routes.splashScreen);
   }catch(e){
     rethrow;
   }
  }
}