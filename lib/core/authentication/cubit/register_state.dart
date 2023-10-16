part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisiterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({required this.user}) : super();

  final UserCredential user;
}

final class RegisterFailure extends RegisterState {
  const RegisterFailure({required this.failure}) : super();

  final Failure failure;
}
