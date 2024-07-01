import 'package:dio/dio.dart';
import '../services/user_provider.dart';
final headers={
  'cookie': 'accessToken=$token'
};

final dio = Dio(
    BaseOptions(
      headers: headers,
    )
);