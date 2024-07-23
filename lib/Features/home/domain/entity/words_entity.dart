class WordsDataEntity {
  late final String word;
  late final String translate;

  WordsDataEntity({
    required this.word,
    required this.translate,
  });

  WordsDataEntity.fromJson(json){
    word = json['word'];
    translate = json['translate'];
  }
}