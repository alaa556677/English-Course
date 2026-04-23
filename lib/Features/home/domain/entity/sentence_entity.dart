class SentenceDataEntity {
  final String id;
  final String sentence;
  final String translate;
  final String time;

  SentenceDataEntity({this.id = '', required this.sentence, required this.translate, required this.time});

  factory SentenceDataEntity.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return SentenceDataEntity(
      id: id,
      sentence: json['sentence'] ?? '',
      translate: json['translate'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
