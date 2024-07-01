import 'package:flutter/cupertino.dart';

class NavBarService extends ChangeNotifier {
  int _selectedIndex = 0;

  void changeScreen(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void resetProvider(){
    _selectedIndex=0;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
