class InterviewDataEntity {
  late final String interview;
  late final String translate;

  InterviewDataEntity({
    required this.interview,
    required this.translate,
  });

  InterviewDataEntity.fromJson(json){
    interview = json['interview'];
    translate = json['translate'];
  }
}