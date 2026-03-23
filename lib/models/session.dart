class Session {
  final int? id;
  final int chapterId;
  final String teamName;
  final int startTime;
  final int? endTime;
  final int hintsUsed;

  Session({
    this.id,
    required this.chapterId,
    required this.teamName,
    required this.startTime,
    this.endTime,
    required this.hintsUsed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapter_id': chapterId,
      'team_name': teamName,
      'start_time': startTime,
      'end_time': endTime,
      'hints_used': hintsUsed,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] as int?,
      chapterId: map['chapter_id'] as int,
      teamName: map['team_name'] as String,
      startTime: map['start_time'] as int,
      endTime: map['end_time'] as int?,
      hintsUsed: map['hints_used'] as int,
    );
  }
}