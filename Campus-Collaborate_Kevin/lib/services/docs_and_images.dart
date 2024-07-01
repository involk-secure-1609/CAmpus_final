import 'dart:io';
import 'package:flutter/material.dart';

class DocsStateService extends ChangeNotifier
{

  List<File> _docs = [];
  void addDocs(List<File> docs)
  {
    _docs=docs;
    notifyListeners();
  }

  Future<void> removeDocs(File docs)async {
    _docs.remove(docs);
    await docs.delete();
    notifyListeners();
  }

  void resetProvider(){
    _docs.clear();
    notifyListeners();
  }

  List<File> get docs => _docs;
}

class ProjectImageStateService extends ChangeNotifier {
  File? _images ;

  void addImage(File docs) {
    _images=docs;
    print(_images!.path);
    notifyListeners();
  }

  Future<void> removeDocs(File docs) async{
    _images=null;
    await docs.delete();
    notifyListeners();
  }

  void resetProvider(){
    _images =null;
    notifyListeners();
  }

  File? get images => _images;
}
