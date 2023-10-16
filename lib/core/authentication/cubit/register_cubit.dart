import 'package:alquran/core/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/failure.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final repo = AuthenticationRepository();

  void register(String email, password) async {
    emit(RegisiterLoading());

    var result = await repo.register(email, password);
    result.fold((l) => emit(RegisterFailure(failure: l)),
        (r) => emit(RegisterSuccess(user: r)));
  }
}
