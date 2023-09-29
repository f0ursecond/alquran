// ignore_for_file: unnecessary_this

class Prayer {
  String? title;
  String? arabic;
  String? latin;
  String? translation;

  Prayer({this.title, this.arabic, this.latin, this.translation});

  Prayer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    arabic = json['arabic'];
    latin = json['latin'];
    translation = json['translation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['arabic'] = this.arabic;
    data['latin'] = this.latin;
    data['translation'] = this.translation;
    return data;
  }
}
