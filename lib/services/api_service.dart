import 'dart:convert';
import 'dart:developer';

import 'package:notesapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static String _baseUrl = "http://188.27.130.222:5000/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
  
  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
  Uri requestUri = Uri.parse("$_baseUrl/list");
  var response = await http.get(requestUri, headers: {"Content-Type": "application/json"});
  
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    
    List<Note> notes = [];
    for(var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  } else {
    // Handle errors, log, or throw an exception
    throw Exception('Failed to fetch notes');
  }
}

}