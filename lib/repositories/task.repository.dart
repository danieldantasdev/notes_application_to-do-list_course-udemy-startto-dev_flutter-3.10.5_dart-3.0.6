import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskRepository {
  late final SharedPreferences _sharedPreferences;

  void save(List<Task> tasks) {
    final String jsonString = json.encode(tasks);
    _add('task_list', jsonString);
  }

  Future<List<Task>> get(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = _sharedPreferences.getString(key) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Task.FromJson(e)).toList();
  }

  void _add(String key, dynamic value) {
    _sharedPreferences.setString(key, value);
  }
}
