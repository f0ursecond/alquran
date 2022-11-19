import 'package:crud/model/quran_model.dart';

import 'package:crud/services/quran_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuranProvider extends ChangeNotifier {
  final _service = QuranService();
  bool isLoading = false;
  List<quran> _alquran = [];
  List<quran> get alquran => _alquran;

  Future<void> getAllQuran() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();
    _alquran = response;
    isLoading = false;
    notifyListeners();
  }
}
