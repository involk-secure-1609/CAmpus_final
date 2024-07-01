import 'package:campuscollaborate/models/user_info.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  UserInfo _userInfo=UserInfo(name: '', rollNumber: '', skills: [], courses: [], email: '', url: '', program: '', projects: []);
  void setUser(UserInfo userInfo){
    _userInfo=userInfo;
    notifyListeners();
  }
  UserInfo get userInfo=>_userInfo;
}


String token="";