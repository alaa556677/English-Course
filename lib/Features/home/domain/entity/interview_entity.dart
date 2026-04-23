class InterviewDataEntity {
  final String id;
  final String interview;
  final String translate;
  final String time;

  InterviewDataEntity({this.id = '', required this.interview, required this.translate, required this.time});

  factory InterviewDataEntity.fromJson(Map<String, dynamic> json, {String id = ''}) {
    return InterviewDataEntity(
      id: id,
      interview: json['interview'] ?? '',
      translate: json['translate'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
