class SentenceDataEntity {
  late final String sentence;
  late final String translate;

  SentenceDataEntity({
    required this.sentence,
    required this.translate,
  });

  SentenceDataEntity.fromJson(json){
    sentence = json['sentence'];
    translate = json['translate'];
  }
}