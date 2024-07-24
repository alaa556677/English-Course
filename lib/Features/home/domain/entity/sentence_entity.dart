class SentenceDataEntity {
  late final String sentence;
  late final String translate;
  late final String uid;

  SentenceDataEntity({
    required this.sentence,
    required this.translate,
    required this.uid,
  });

  SentenceDataEntity.fromJson(json){
    sentence = json['sentence'];
    translate = json['translate'];
    uid = json['uid'];
  }
}