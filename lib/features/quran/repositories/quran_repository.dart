// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:alquran/features/quran/models/alquran_detail_model.dart';
import 'package:alquran/features/quran/models/alquran_model.dart';
import 'package:alquran/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class QuranRepository {
  Future<Either<Failure, List<Quran>>> getListQuran() async {
    try {
      final response = await http.get(
        Uri.parse('https://equran.id/api/v2/surat'),
      );
      final body = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
        case 201:
          final List<dynamic> data = body['data'];
          final resultList = data.map((e) => Quran.fromJson(e)).toList();
          return Right(resultList);
        case 400:
          return const Left(BadRequestFailure(message: '400 | Error'));
        case 404:
          return const Left(ServerFailure(message: "404 | Not Found"));
        default:
          return const Left(ServerFailure(
            message: "500 | Something Wrong With Server",
          ));
      }
    } on SocketException {
      return const Left(ServerFailure(message: 'No Connection'));
    } on TimeoutException {
      return const Left(ServerFailure(message: 'Connection timeout'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ResQuranDetail>> getQuranById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('https://equran.id/api/v2/surat/$id'),
      );
      final body = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
        case 201:
          return Right(ResQuranDetail.fromJson(body['data'] ?? {}));
        case 400:
          return const Left(BadRequestFailure(message: '400 | Error'));
        case 404:
          return const Left(ServerFailure(message: "404 | Not Found"));
        default:
          return const Left(ServerFailure(
            message: "500 | Something Wrong With Server",
          ));
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
