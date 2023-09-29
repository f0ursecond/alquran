// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alquran/features/quran/models/alquran_model.dart';
import 'package:alquran/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class QuranRepository {
  Future<Either<Failure, List<Quran>>> getListQuran() async {
    try {
      final response =
          await http.get(Uri.parse('https://equran.id/api/v2/surat'));

      final body = jsonDecode(response.body);
      print('response =>> ' + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = body['data'];
        final resultList = data.map((e) => Quran.fromJson(e)).toList();
        return Right(resultList);
      } else {
        return const Left(ResponseEmptyFailure(message: 'Data Kosong'));
      }
    } on SocketException {
      return const Left(ServerFailure(message: 'No Connection'));
    } on TimeoutException {
      return const Left(ServerFailure(message: 'Connection timeout'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
