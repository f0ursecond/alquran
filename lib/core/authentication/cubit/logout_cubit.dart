import 'package:alquran/core/authentication/authentication_repository.dart';
import 'package:alquran/utils/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  final repo = AuthenticationRepository();

  void logOut() async {
    emit(LogoutLoading());

    var result = await repo.signOut();
    result.fold(
      (l) => emit(LogoutFailure(failure: l)),
      (r) => emit(LogoutSuccess(result: r)),
    );
  }
}
