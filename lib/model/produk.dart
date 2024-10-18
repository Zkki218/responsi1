class Produk {
  int? id;
  String? original_language;
  String? translated_language;
  String? translator_name;
  Produk({this.id, this.original_language, this.translated_language, this.translator_name});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        original_language: obj['original_language'],
        translated_language: obj['translated_language'],
        translator_name: obj['translator_name']);
  }
}
