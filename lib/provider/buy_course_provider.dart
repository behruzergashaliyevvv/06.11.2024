import 'package:flutter/material.dart';
import 'package:dars/models/course.dart';

class BuyCourseProvider with ChangeNotifier {
  final List<Course> _boughtCourses = [];

  List<Course> get boughtCourses => _boughtCourses;

  void addBoughtCourse(Course course) {
    if (!_boughtCourses.contains(course)) {
      _boughtCourses.add(course);
      notifyListeners();
    }
  }
}
