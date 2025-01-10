import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/todo_model.dart';
import '../../../service/dio_service.dart';
import '../../../service/result.dart';

class HomeDatasource {
  String endpoint = "/todo";

  Future<Result<List<TodoModel>>> fetchTodos() async {
    final dio = DioService().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.get('$endpoint/${prefs.getString("userID")}');

      final data = response.data;
      final List<dynamic> tasksData = data['todos'];
      final int consecutiveDays = data['consecutiveDays'];

      final todos = tasksData.map((e) {
        final todo = TodoModel.fromJson(e);
        return todo.copyWith(consecutiveDays: consecutiveDays);
      }).toList();

      final String jsonString =
          jsonEncode(todos.map((e) => e.toJson()).toList());
      await prefs.setString("todos", jsonString);

      return Result.success(todos);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<TodoModel>> create(TodoModel newTodo) async {
    final dio = DioService().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post('$endpoint/${prefs.getString("userID")}',
          data: newTodo.toJson());
      final data = response.data;
      final todo = TodoModel.fromJson(data);
      final String jsonString = prefs.getString("todos") ?? "[]";
      final List<TodoModel> todos = (jsonDecode(jsonString) as List)
          .map((e) => TodoModel.fromJson(e))
          .toList();
      todos.add(todo);
      await prefs.setString(
          "todos", jsonEncode(todos.map((e) => e.toJson()).toList()));
      return Result.success(todo);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<TodoModel>> update(TodoModel todo) async {
    final dio = DioService().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response =
          await dio.put('$endpoint/${todo.id}', data: todo.toJson());
      final data = response.data;
      final updatedTodo = TodoModel.fromJson(data);
      final String jsonString = prefs.getString("todos") ?? "[]";
      final List<TodoModel> todos = (jsonDecode(jsonString) as List)
          .map((e) => TodoModel.fromJson(e))
          .toList();
      final index = todos.indexWhere((element) => element.id == updatedTodo.id);
      todos[index] = updatedTodo;
      await prefs.setString(
          "todos", jsonEncode(todos.map((e) => e.toJson()).toList()));
      return Result.success(updatedTodo);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<bool> delete(String id) async {
    final dio = DioService().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await dio.delete('$endpoint/$id');
      final String jsonString = prefs.getString("todos") ?? "[]";
      final List<TodoModel> todos = (jsonDecode(jsonString) as List)
          .map((e) => TodoModel.fromJson(e))
          .toList();
      todos.removeWhere((todo) => todo.id == id);
      await prefs.setString(
          "todos", jsonEncode(todos.map((e) => e.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }
}
