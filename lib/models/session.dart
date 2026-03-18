class Session {
  final int? id;
  final int chapterId;
  final String teamName;
  final int startTime;
  final int? endTime;
  final int hintsUsed;

  Session({this.id, required this.chapterId, required this.teamName, required this.startTime, required this.endTime, required this.hintsUsed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teamName': teamName,
      'startTime': startTime,
      'endTime': endTime,
      'hints used': hintsUsed
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      chapterId: map['mission id'],
      teamName: map['teamName'],
      startTime: map['start time'],
      endTime: map['end time'],
      hintsUsed: map['hints used']
    );
  }
}