class WordsDataEntity {
  late final String word;
  late final String translate;
  late final String uid;

  WordsDataEntity({
    required this.word,
    required this.translate,
    required this.uid,
  });

  WordsDataEntity.fromJson(json){
    word = json['word'];
    translate = json['translate'];
    uid = json['uid'];
  }
}