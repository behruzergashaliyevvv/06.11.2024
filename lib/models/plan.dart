class Plan {
  String id;
  String title;
  String description;

  Plan({required this.id, required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Plan.fromJson(String id, Map<String, dynamic> json) {
    return Plan(
      id: id,
      title: json['title'],
      description: json['description'],
    );
  }
}
