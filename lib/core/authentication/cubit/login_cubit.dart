import 'package:alquran/core/authentication/authentication_repository.dart';
import 'package:alquran/utils/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final repo = AuthenticationRepository();

  void login(String email, password) async {
    emit(LoginLoading());

    var result = await repo.signIn(email, password);
    result.fold(
      (l) => emit(LoginFailure(failure: l)),
      (r) => emit(LoginSuccess(user: r)),
    );
  }
}
