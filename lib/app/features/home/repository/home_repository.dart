import 'package:getitdone/app/features/home/datasource/home_datasource.dart';

import '../../../models/todo_model.dart';
import '../../../service/result.dart';

class HomeRepository {
  final HomeDatasource datasource;

  HomeRepository({required this.datasource});

  Future<Result<List<TodoModel>>> fetchTodos() async {
    return await datasource.fetchTodos();
  }

  Future<Result<TodoModel>> create(TodoModel newTodo) async {
    return await datasource.create(newTodo);
  }

  Future<Result<TodoModel>> update(TodoModel todo) async {
    return await datasource.update(todo);
  }

  Future<bool> delete(String id) async {
    return await datasource.delete(id);
  }
}
