import 'dart:convert';

import 'package:crud/model/quran_model.dart';
import 'package:http/http.dart' as http;

class QuranService {
  Future<List<quran>> getAll() async {
    try {
      String url = 'https://equran.id/api/surat';
      var response = await http.get(Uri.parse(url));

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = body;
        List<quran> result = data.map((e) => quran.fromJson(e)).toList();

        return result;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
