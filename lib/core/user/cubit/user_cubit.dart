import 'package:alquran/core/user/models/user_model.dart';
import 'package:alquran/core/user/repositories/user_repository.dart';
import 'package:alquran/utils/failure.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  UserRepository repo = UserRepository();

  Future<void> getUsers() async {
    emit(UserLoading());

    var result = await repo.getUsers();
    result.fold(
      (l) => emit(UserFailure(failure: l)),
      (r) => emit(UserSuccess(result: r)),
    );
  }

  Future<void> deleteUsers(String id, [String? name]) async {
    emit(UserDeleteLoading());

    var result = await repo.deleteUsers(id);
    result.fold(
      (l) => emit(UserDeleteFailure(failure: l)),
      (r) => emit(UserDeleteSuccess(id: id, name: name)),
    );
  }

  Future<void> createUser(String name, String avatarUrl, String age) async {
    emit(CreateUserLoading());

    var result = await repo.createUser(name, avatarUrl, age);
    result.fold(
      (l) => emit(CreateUserFailure(failure: l)),
      (r) => emit(CreateUserSuccess()),
    );
  }
}
