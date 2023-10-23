import 'dart:convert';
import 'dart:io';

import 'package:alquran/core/user/models/user_model.dart';
import 'package:alquran/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      String url = 'https://65228ebdf43b17938414a1e8.mockapi.io/api/users';

      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });

      final body = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          List<dynamic> data = body;
          List<UserModel> result =
              data.map((e) => UserModel.fromJson(e)).toList();
          return Right(result);
        case 400:
          return const Left(BadRequestFailure(message: 'Bad Request'));
        case 404:
          return const Left(ServerFailure(message: "404 | Not Found"));
        default:
          return const Left(
            ServerFailure(
              message: "500 | Something Wrong With Server",
            ),
          );
      }
    } on SocketException {
      return const Left(ServerFailure(message: 'Tidak Ada Koneksi'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteUsers(String id) async {
    try {
      String url = 'https://65228ebdf43b17938414a1e8.mockapi.io/api/users/$id';

      final response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.acceptHeader: 'application/json',
      });

      // final body = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          return const Right(true);
        case 400:
          return const Left(BadRequestFailure(message: 'Bad Request'));
        case 404:
          return const Left(ServerFailure(message: "404 | Not Found"));
        default:
          return const Left(
            ServerFailure(message: "500 | Something Wrong With Server"),
          );
      }
    } on SocketException {
      return const Left(ServerFailure(message: 'Tidak Ada Koneksi'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
