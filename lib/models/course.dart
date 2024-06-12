class Course {
  String id;
  String title;
  String description;
  String imageUrl;
  List<Lesson> lessons;
  double price;
  bool isFavorite;
  bool isInBasket;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessons,
    required this.price,
    this.isFavorite =false,
    this.isInBasket = false,
  });

  // get isFavorite => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
      'price': price,
    };
  }

  factory Course.fromJson(String id, Map<String, dynamic> json) {
    return Course(
      id: id,
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      lessons: json['lessons'] != null 
          ? (json['lessons'] as List<dynamic>)
              .map((e) => Lesson.fromJson(e['id'], e))
              .toList()
          : [],
      price: json['price'],
    );
  }
}

class Lesson {
  String id;
  String courseId;
  String title;
  String description;
  String videoUrl;
  List<Quiz> quizes;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.quizes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'quizes': quizes.map((quiz) => quiz.toJson()).toList(),
    };
  }

  factory Lesson.fromJson(String id, Map<String, dynamic> json) {
    return Lesson(
      id: id,
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      quizes: json['quizes'] != null 
          ? (json['quizes'] as List<dynamic>)
              .map((e) => Quiz.fromJson(e['id'], e))
              .toList()
          : [],
    );
  }
}

class Quiz {
  String id;
  String question;
  List<String> options;
  int correctOptionIndex;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }

  factory Quiz.fromJson(String id, Map<String, dynamic> json) {
    return Quiz(
      id: id,
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
    );
  }
}
