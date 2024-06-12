import 'package:flutter/material.dart';
import 'package:dars/models/course.dart';

class FavoriteCoursesProvider with ChangeNotifier {
  List<Course> _favoriteCourses = [];

  List<Course> get favoriteCourses => _favoriteCourses;

  void toggleFavoriteStatus(Course course) {
    course.isFavorite = !course.isFavorite;
    if (course.isFavorite) {
      _favoriteCourses.add(course);
    } else {
      _favoriteCourses.removeWhere((c) => c.id == course.id);
    }
    notifyListeners();
  }
}
