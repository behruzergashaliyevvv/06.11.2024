import 'package:dars/models/course.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import '../models/plan.dart';
import '../models/note.dart';


class ApiService {
  static const String baseUrl = 'https://plan-336c2-default-rtdb.firebaseio.com';

  static Future<void> savePlan(Plan plan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/plans.json'),
      body: json.encode(plan.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save plan');
    }
  }

  static Future<void> saveNote(Note note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes.json'),
      body: json.encode(note.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save note');
    }
  }

  static Future<void> deletePlan(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/plans/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete plan');
    }
  }

  static Future<void> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }

  static Future<List<Plan>> fetchPlans() async {
    final response = await http.get(Uri.parse('$baseUrl/plans.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data.entries.map((e) => Plan.fromJson(e.key, e.value)).toList();
    } else {
      throw Exception('Failed to load plans');
    }
  }

  static Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data.entries.map((e) => Note.fromJson(e.key, e.value)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  static Future<void> saveCourse(Course course) async {
    final response = await http.post(
      Uri.parse('$baseUrl/courses.json'),
      body: json.encode(course.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save course');
    }
  }

  static Future<void> deleteCourse(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/courses/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete course');
    }
  }

  static Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data.entries.map((e) => Course.fromJson(e.key, e.value)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
  static Future<void> submitQuizResult(int score) async {
    final response = await http.post(
      Uri.parse('$baseUrl/quiz_results.json'),
      body: json.encode({'score': score}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to submit quiz result');
    }
  }
}
