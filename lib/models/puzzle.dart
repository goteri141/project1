class Puzzle {
  final int? id;
  final int chapterId;
  final String question;
  final String answer;
  final String hint;

  Puzzle({this.id, required this.chapterId, required this.question, required this.answer, required this.hint});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapter_id': chapterId,
      'question': question,
      'solution': answer,
      'hint': hint
      
    };
  }

  factory Puzzle.fromMap(Map<String, dynamic> map) {
    return Puzzle(
      id: map['id'],
      chapterId: map['chapter_id'],
      question: map['question'],
      answer: map['solution'],
      hint: map['hint'],
    );
  }
}