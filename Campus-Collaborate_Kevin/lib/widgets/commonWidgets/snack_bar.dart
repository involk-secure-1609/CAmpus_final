import 'package:flutter/material.dart';



SnackBar showCommonSnackBar(String text){
  return SnackBar(content: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16),));
}
