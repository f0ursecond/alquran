import 'package:alquran/features/quran/models/alquran_model.dart';
import 'package:alquran/features/quran/repositories/quran_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  QuranRepository repository = QuranRepository();

  Future<void> getListQuran() async {
    emit(QuranLoading());

    var result = await repository.getListQuran();
    result.fold(
      (l) => emit(QuranFailure(message: l.message)),
      (r) => emit(QuranSuccess(resultList: r)),
    );
  }
}
