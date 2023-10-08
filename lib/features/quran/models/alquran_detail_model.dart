class ResQuranDetail {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Ayat> ayat;
  final NextAndPrev? suratSelanjutnya;
  final NextAndPrev? suratSebelumnya;

  ResQuranDetail({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    required this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory ResQuranDetail.fromJson(Map<String, dynamic> json) => ResQuranDetail(
        nomor: json['nomor'],
        nama: json['nama'],
        namaLatin: json['namaLatin'],
        jumlahAyat: json['jumlahAyat'],
        tempatTurun: json['tempatTurun'],
        arti: json['arti'],
        deskripsi: json['deskripsi'],
        audioFull: Map<String, String>.from(json['audioFull'] ?? {}),
        ayat: (json['ayat'] as List<dynamic>?)
                ?.map((ayatJson) => Ayat.fromJson(ayatJson))
                .toList() ??
            [],
        suratSelanjutnya: json['suratSelanjutnya'] != null &&
                json['suratSelanjutnya'] != false
            ? NextAndPrev.fromJson(json['suratSelanjutnya'])
            : null,
        suratSebelumnya:
            json['suratSebelumnya'] != null && json['suratSebelumnya'] == true
                ? NextAndPrev.fromJson(json['suratSebelumnya'])
                : null,
      );
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksLatin: json['teksLatin'],
      teksIndonesia: json['teksIndonesia'],
      audio: Map<String, String>.from(json['audio'] ?? {}),
    );
  }
}

class NextAndPrev {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  NextAndPrev({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory NextAndPrev.fromJson(Map<String, dynamic> json) {
    return NextAndPrev(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
    );
  }
}
