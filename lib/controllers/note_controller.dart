import 'package:dars/database/sql_helper.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';


class NoteController with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NoteController() {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final dataList = await SQLHelper.getNotes();
    _notes = dataList.map((item) => Note(
      id: item['id'],
      productName: item['productName'],
      price: item['price'],
      amount: item['amount'],
    )).toList();
    notifyListeners();
  }

  Future<void> addNote(String productName, double price, int amount) async {
    final newNote = Note(
      id: DateTime.now().toString(),
      productName: productName,
      price: price,
      amount: amount,
    );
    _notes.add(newNote);
    notifyListeners();
    await SQLHelper.createNote(newNote.id, productName, price, amount);
    await _loadNotes(); // Reload notes from database
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
    await SQLHelper.deleteNote(id);
    await _loadNotes(); // Reload notes from database
  }
}
