import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});
  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class ResponseEmptyFailure extends Failure {
  const ResponseEmptyFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class ExceptionFailure extends Failure {
  const ExceptionFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
