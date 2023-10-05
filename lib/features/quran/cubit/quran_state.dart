// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

part of 'quran_cubit.dart';

sealed class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

final class QuranInitial extends QuranState {}

final class QuranLoading extends QuranState {}

final class QuranSuccess extends QuranState {
  QuranSuccess({required this.resultList, this.query = ""}) : super();

  final List<Quran> resultList;
  final String query;

  List<Object>? get Props => [resultList, query];
}

final class QuranFailure extends QuranState {
  QuranFailure({required this.message});

  final String message;
}
