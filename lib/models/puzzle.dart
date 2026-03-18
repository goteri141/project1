class Puzzle {
  final int? id;
  final int chapterId;
  final String question;
  final String answer;
  final String hint;
  final int orderIndex;

  Puzzle({this.id, required this.chapterId, required this.question, required this.answer, required this.hint, required this.orderIndex});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mission id': chapterId,
      'question': question,
      'answer': answer,
      'hint': hint,
      'order index': orderIndex,
    };
  }

  factory Puzzle.fromMap(Map<String, dynamic> map) {
    return Puzzle(
      id: map['id'],
      chapterId: map['mission id'],
      question: map['question'],
      answer: map['answer'],
      hint: map['hint'],
      orderIndex: map['order index'],
    );
  }
}