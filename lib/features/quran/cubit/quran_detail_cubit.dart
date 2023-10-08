import 'package:alquran/features/quran/models/alquran_detail_model.dart';
import 'package:alquran/features/quran/repositories/quran_repository.dart';
import 'package:alquran/utils/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quran_detail_state.dart';

class QuranDetailCubit extends Cubit<QuranDetailState> {
  QuranDetailCubit() : super(QuranDetailInitial());

  final QuranRepository repository = QuranRepository();

  Future getQuranById(int id) async {
    emit(QuranDetailLoading());
    var result = await repository.getQuranById(id);

    result.fold(
      (l) => emit(QuranDetailFailure(message: l)),
      (r) => emit(QuranDetailSuccess(result: r, id: id)),
    );
  }
}
