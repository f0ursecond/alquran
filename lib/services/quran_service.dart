import 'dart:convert';

import 'package:crud/model/quran_model.dart';
import 'package:http/http.dart' as http;

class QuranService {
  Future<List<quran>> getAll() async {
    const url = 'https://equran.id/api/surat';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = (jsonDecode(utf8.decode(response.bodyBytes))) as List;
        final alquran = json.map((e) {
          return quran(
              nomor: e['nomor'],
              nama: e['nama'],
              nama_latin: e['nama_latin'],
              jumlah_ayat: e['jumlah_ayat'],
              tempat_turun: e['tempat_turun'],
              arti: e['arti'],
              deskripsi: e['deskripsi'],
              audio: e['audio']);
        }).toList();
        return alquran;
      } else {
        throw ('Error: ${response.statusCode}');
      }
    } catch (err) {
      throw (err);
    }
  }
}

// if (response.statusCode == 200) {
      
//     }