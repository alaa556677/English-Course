class WordsDataEntity {
  final String id;
  final String word;
  final String translate;
  final String time;

  WordsDataEntity({this.id = '', required this.word, required this.translate, required this.time});

  factory WordsDataEntity.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return WordsDataEntity(
      id: id,
      word: json['word'] ?? '',
      translate: json['translate'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
