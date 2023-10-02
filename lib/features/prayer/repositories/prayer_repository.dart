// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:alquran/features/prayer/model/prayer_model.dart';
import 'package:alquran/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class PrayerRepository {
  Future<Either<Failure, List<Prayer>>> getListPrayer() async {
    try {
      final response = await http.get(
          Uri.parse('https://islamic-api-zhirrr.vercel.app/api/doaharian'));

      print('response =>> ' + response.statusCode.toString());

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final List<dynamic> data = body['data'];
          final resultList = data.map((e) => Prayer.fromJson(e)).toList();
          return Right(resultList);
        } catch (e) {
          return Left(ServerFailure(message: e.toString()));
        }
      } else if (response.statusCode == 401) {
        return const Left(UnauthorizedFailure(message: 'Please Login'));
      } else if (response.statusCode == 400) {
        return const Left(BadRequestFailure(message: 'Bad Request'));
      } else if (response.statusCode == 404) {
        return const Left(ServerFailure(message: '404 Not Found'));
      } else {
        return const Left(ResponseEmptyFailure(message: 'Kosong'));
      }
    } on SocketException {
      return const Left(ServerFailure(message: 'No Connection'));
    } on TimeoutException {
      return const Left(ServerFailure(message: 'Connection timeout'));
    } on Error catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
