class Chapter {
  final int id;
  final String title;
  final String description;

  Chapter({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}