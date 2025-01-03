import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/home/repository/home_repository.dart';
import 'package:getitdone/app/models/todo_model.dart';
import 'package:getitdone/app/shared/providers/user_provider.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  final UserProvider userProvider;
  final List<TodoModel> todos = [];
  final List<TodoModel> completedTodos = [];
  final isLoading = false.obs;
  HomeController({required this.repository, required this.userProvider});

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  Rx<bool> reminderSelected = false.obs;
  Rx<bool> isCalendarShown = false.obs;

  void clearControllers() {
    taskNameController.clear();
    taskDescriptionController.clear();
    selectedDate.value = null;
    selectedTime.value = null;
    reminderSelected.value = false;
  }

  void toggleCalendarShown() {
    isCalendarShown.value = !isCalendarShown.value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    isLoading.value = true;
    final result = await repository.fetchTodos();

    result.fold(
      (sucess) {
        todos.clear();
        todos.addAll(sucess);
        completedTodos.addAll(sucess.where((e) => e.completed == true));
        todos.sort(
            (a, b) => a.completed == b.completed ? 0 : (a.completed ? 1 : -1));

        isLoading.value = false;
        update();
      },
      (error) {
        fetchTodos();
      },
    );
  }

  void create(TodoModel newTodo) async {
    isLoading.value = true;
    final result = await repository.create(newTodo);

    result.fold(
      (sucess) {
        todos.add(sucess);
        isLoading.value = false;
        clearControllers();
        Get.back();
        update();
      },
      (error) {
        Get.snackbar('Erro', 'Não foi possível criar a tarefa',
            colorText: Get.theme.snackBarTheme.actionTextColor,
            backgroundColor: Get.theme.snackBarTheme.backgroundColor);
      },
    );
  }

  void updateTodo(TodoModel todo) async {
    final result = await repository.update(todo);

    result.fold(
      (sucess) {
        final index = todos.indexWhere((element) => element.id == sucess.id);
        todos[index] = sucess;
        Get.snackbar('Sucesso', 'Você marcou como feita a tarefa',
            colorText: Colors.white, backgroundColor: Colors.green);
        fetchTodos();
        getCompletedTasksByDate(todos);
        update();
      },
      (error) {
        Get.snackbar('Erro', 'Não foi possível atualizar a tarefa',
            colorText: Get.theme.snackBarTheme.actionTextColor,
            backgroundColor: Get.theme.snackBarTheme.backgroundColor);
      },
    );
  }

  void deleteTodo(String id) async {
    final result = await repository.delete(id);
    if (!result) {
      Get.snackbar('Erro', 'Não foi possível deletar a tarefa',
          colorText: Get.theme.snackBarTheme.actionTextColor,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor);
    }

    todos.removeWhere((todo) => todo.id == id);
    update();
    Get.snackbar('Sucesso', 'Você excluiu a tarefa',
        colorText: Colors.white, backgroundColor: Colors.green);
  }

  Map<DateTime, int> getCompletedTasksByDate(List<TodoModel> todos) {
    Map<DateTime, int> completedTasks = {};

    for (var todo in todos) {
      if (todo.completed && todo.completedDate != null) {
        DateTime date = DateTime(
          todo.completedDate!.year,
          todo.completedDate!.month,
          todo.completedDate!.day,
        );

        if (completedTasks.containsKey(date)) {
          completedTasks[date] = completedTasks[date]! + 1;
        } else {
          completedTasks[date] = 1;
        }
      }
    }

    return completedTasks;
  }
}
