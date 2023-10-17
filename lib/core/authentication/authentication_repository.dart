import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/failure.dart';

class AuthenticationRepository {
  Future<Either<Failure, UserCredential>> register(
      String email, String password) async {
    try {
      final reg = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(reg);
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          'An error occurred during registration. Check Your Connection & Try Again';

      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email sudah Terdaftar';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password harus lebih dari 6 karakter';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email tidak valid';
      }

      return Left(ServerFailure(message: errorMessage));
    } on SocketException {
      return const Left(ServerFailure(message: 'Tidak Ada Koneksi'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserCredential>> signIn(
      String email, String password) async {
    try {
      final reg = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(reg);
    } on FirebaseAuthException catch (e) {
      print('this is e code => ${e.code}');
      String errorMessage =
          'An error occurred during registration. Check Your Connection & Try Again';

      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMessage = 'The password or email you entered is incorrect';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email tidak valid';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Please Try Again Later';
      }

      return Left(ServerFailure(message: errorMessage));
    } on SocketException {
      return const Left(ServerFailure(message: 'Tidak Ada Koneksi'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      print('this is e code => ${e.code}');
      String errorMessage =
          'An error occurred during registration. Check Your Connection & Try Again';

      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMessage = 'The password or email you entered is incorrect';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email tidak valid';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Please Try Again Later';
      }

      return Left(ServerFailure(message: errorMessage));
    } on SocketException {
      return const Left(ServerFailure(message: 'Tidak Ada Koneksi'));
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
