
import 'package:flutter/material.dart';
import 'package:dars/models/course.dart';

class BasketCourseProvider with ChangeNotifier {
  List<Course> _basketCourses = [];

  List<Course> get basketCourses => _basketCourses;

  void toggleBasketStatus(Course course) {
    course.isInBasket = !course.isInBasket;
    if (course.isInBasket) {
      _basketCourses.add(course);
    } else {
      _basketCourses.removeWhere((c) => c.id == course.id);
    }
    notifyListeners();
  }
}
