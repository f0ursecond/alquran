part of 'quran_detail_cubit.dart';

sealed class QuranDetailState extends Equatable {
  const QuranDetailState();

  @override
  List<Object> get props => [];
}

final class QuranDetailInitial extends QuranDetailState {}

final class QuranDetailLoading extends QuranDetailState {}

final class QuranDetailSuccess extends QuranDetailState {
  const QuranDetailSuccess({required this.result, required this.id}) : super();
  final int id;
  final ResQuranDetail result;
}

final class QuranDetailFailure extends QuranDetailState {
  const QuranDetailFailure({required this.message}) : super();
  final Failure message;
}
