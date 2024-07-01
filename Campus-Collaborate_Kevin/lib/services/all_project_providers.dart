import 'package:flutter/cupertino.dart';

import '../models/project.dart';

class AllProjectsProvider extends ChangeNotifier{
  List<Project> _allProjects=[];

  void setFetchedProjects(List<Project> list){
    _allProjects=list;
    notifyListeners();
  }

  List<Project> get allProjects =>_allProjects;
}