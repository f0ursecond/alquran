import 'package:alquran/features/prayer/model/prayer_model.dart';
import 'package:alquran/features/prayer/repositories/prayer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());

  final repository = PrayerRepository();

  Future getPrayerList() async {
    emit(PrayerListLoading());
    var result = await repository.getListPrayer();
    result.fold((l) => emit(PrayerListFailure(message: l.message)),
        (r) => emit(PrayerListSucces(listPrayer: r)));
  }
}
