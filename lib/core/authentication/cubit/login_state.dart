part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  const LoginSuccess({required this.user}) : super();

  final UserCredential user;
}

final class LoginFailure extends LoginState {
  const LoginFailure({required this.failure}) : super();

  final Failure failure;
}
