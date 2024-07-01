import 'dart:convert';

import 'package:campuscollaborate/widgets/commonWidgets/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> httpHandler(Response response, void Function() onSuccess, BuildContext context)async{
 switch(response.statusCode)
 {
   case 200:
     onSuccess;
     break;
   case 400:
     ScaffoldMessenger.of(context).showSnackBar(showCommonSnackBar(jsonDecode(response.data)['message']));
 }
}