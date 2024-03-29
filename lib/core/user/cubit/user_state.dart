part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

//GET USER

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  const UserSuccess({required this.result}) : super();

  final List<UserModel> result;
}

final class UserFailure extends UserState {
  const UserFailure({required this.failure}) : super();

  final Failure failure;
}

//DELETE USER

final class UserDeleteLoading extends UserState {}

final class UserDeleteSuccess extends UserState {
  const UserDeleteSuccess({required this.id, this.name}) : super();
  final String id;
  final String? name;
}

final class UserDeleteFailure extends UserState {
  const UserDeleteFailure({required this.failure}) : super();

  final Failure failure;
}

// CREATE USER

final class CreateUserLoading extends UserState {}

final class CreateUserSuccess extends UserState {}

final class CreateUserFailure extends UserState {
  const CreateUserFailure({required this.failure}) : super();

  final Failure failure;
}

// UPDATE USER

final class UpdateUserLoading extends UserState {}

final class UpdateUserSuccess extends UserState {
  const UpdateUserSuccess({required this.id}) : super();

  final String id;
}

final class UpdateUserFailure extends UserState {
  const UpdateUserFailure({required this.failure}) : super();

  final Failure failure;
}
