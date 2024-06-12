import 'package:dars/models/course.dart';
import 'package:flutter/material.dart';

class CourseController extends ChangeNotifier {
  List<Course> _courses = [];

  List<Course> get courses => _courses;

  void addCourse(String title, String description, String imageUrl, List<Lesson> lessons, double price) {
    final newCourse = Course(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      imageUrl: imageUrl,
      lessons: lessons,
      price: price,
    );
    _courses.add(newCourse);
    notifyListeners();
  }

  void deleteCourse(String id) {
    _courses.removeWhere((course) => course.id == id);
    notifyListeners();
  }
}

