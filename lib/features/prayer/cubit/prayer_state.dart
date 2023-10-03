part of 'prayer_cubit.dart';

@immutable
sealed class PrayerState {}

final class PrayerInitial extends PrayerState {}

final class PrayerListLoading extends PrayerState {}

final class PrayerListSucces extends PrayerState {
  PrayerListSucces({required this.listPrayer, this.query = ""});
  final String query;
  final List<Prayer> listPrayer;

  List<Object>? get props => [listPrayer, query];
}

final class PrayerListFailure extends PrayerState {
  PrayerListFailure({required this.message});

  final String message;
}
