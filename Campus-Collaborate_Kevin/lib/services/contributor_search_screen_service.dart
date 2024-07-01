import 'package:flutter/material.dart';
import '../models/admin.dart';


class ContributorSearchScreenService extends ChangeNotifier
{
  bool _searchClicked=false;
  List<Admin> _searchedUsers=[];
  bool _dataFetched=false;
  Admin? _selectedAdmin;
  final List<Admin> _selectedAdminsList=[];

  void setSearchingAsTrue()
  {
    _searchClicked=true;
    notifyListeners();
  }

  void setSearchingAsFalse()
  {
    _searchClicked=false;
    notifyListeners();
  }

  void clearFetchedDataList()
  {
    _searchedUsers.clear();
    notifyListeners();
  }

  void setSearchedUsers(List<Admin> list){
    _dataFetched=true;
    _searchedUsers=list;
    notifyListeners();
  }

  void addSelectedAdmin(Admin admin)
  {
    _selectedAdminsList.add(admin);
    notifyListeners();
  }

  void removeSelectedAdmin(Admin admin){
    _selectedAdminsList.remove(admin);
    notifyListeners();
  }

  void unselectAdmin(Admin admin){
    _selectedAdmin=null;
    notifyListeners();
  }

  void setSelectedAdmin(Admin admin){
    _selectedAdmin=admin;
    notifyListeners();
  }

  void setDataFetchedAsFalse(){
    _dataFetched=false;
    notifyListeners();
  }

  void clearAllProviders(){
    _searchedUsers.clear();
    _searchClicked=false;
    _dataFetched=false;
    _selectedAdmin=null;
    _selectedAdminsList.clear();
    notifyListeners();
  }

  bool get searchClicked=>_searchClicked;
  List<Admin> get searchedUsers=>_searchedUsers;
  bool get dataFetched=>_dataFetched;
  Admin? get selectedAdmin=>_selectedAdmin;
  List<Admin> get selectedAdminsList=>_selectedAdminsList;
}