import 'package:flutter/cupertino.dart';

class ProjectStatusToggleButtonService extends ChangeNotifier {
  final List<bool> _selectedList = [true, false];

  void selectButton(int index) {
    if (index == 0) {
      _selectedList[0] = true;
      _selectedList[1] = false;
    } else {
      _selectedList[1] = true;
      _selectedList[0] = false;
    }
    notifyListeners();
  }

  void resetProvider(){
    _selectedList[0]=true;
    _selectedList[1]=false;
    notifyListeners();
  }
  List<bool> get selectedList => _selectedList;
}

class ProjectTypeToggleButtonService extends ChangeNotifier {
  final List<bool> _selectedList = [false, true];

  void selectButton(int index) {
    if (index == 0) {
      _selectedList[0] = true;
      _selectedList[1] = false;
    } else {
      _selectedList[1] = true;
      _selectedList[0] = false;
    }
    notifyListeners();
  }

  void resetProvider(){
    _selectedList[1]=true;
    _selectedList[0]=false;
    notifyListeners();
  }

  List<bool> get selectedList => _selectedList;
}
