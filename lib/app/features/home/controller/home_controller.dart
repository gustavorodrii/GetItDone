import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/home/repository/home_repository.dart';
import 'package:getitdone/app/models/todo_model.dart';
import 'package:getitdone/app/shared/providers/user_provider.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  final UserProvider userProvider;
  final List<TodoModel> todos = [];
  final filteredTodos = <TodoModel>[].obs;
  final List<TodoModel> completedTodos = [];
  final isLoading = false.obs;
  HomeController({required this.repository, required this.userProvider});

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  Rx<bool> reminderSelected = false.obs;
  Rx<bool> isCalendarShown = false.obs;
  Rx<bool> filterByDate = false.obs;

  void clearControllers() {
    taskNameController.clear();
    taskDescriptionController.clear();
    selectedDate.value = null;
    selectedTime.value = null;
    reminderSelected.value = false;
  }

  void toggleCalendarShown() {
    isCalendarShown.value = !isCalendarShown.value;
    clearFilter();
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
        todos.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

        todos.addAll(sucess.where((todo) => !todo.completed));

        completedTodos
            .sort((a, b) => a.completedDate!.compareTo(b.completedDate!));

        completedTodos.addAll(sucess.where((e) => e.completed == true));

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
        Get.snackbar('Error', 'Unable to create task',
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
        final indexCompleted =
            completedTodos.indexWhere((element) => element.id == sucess.id);

        if (sucess.completed) {
          if (index != -1) {
            todos.removeAt(index);
          }
          completedTodos.add(sucess);
        } else {
          if (indexCompleted != -1) {
            completedTodos.removeAt(indexCompleted);
          }
          todos.add(sucess);
        }

        Get.snackbar(
          'Success',
          sucess.completed
              ? 'You marked the task as done'
              : 'You marked the task as undone',
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        update();
      },
      (error) {
        Get.snackbar('Error', 'Unable to update task',
            colorText: Get.theme.snackBarTheme.actionTextColor,
            backgroundColor: Get.theme.snackBarTheme.backgroundColor);
      },
    );
  }

  void deleteTodo(String id) async {
    final result = await repository.delete(id);
    if (!result) {
      Get.snackbar('Error', 'Unable to delete task',
          colorText: Get.theme.snackBarTheme.actionTextColor,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor);
    }

    todos.removeWhere((todo) => todo.id == id);
    completedTodos.removeWhere(
      (todoCompleted) => todoCompleted.id == id,
    );
    update();
    Get.snackbar('Success', 'You have deleted the task',
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

  Map<DateTime, int> getCreatedTasksByDate(List<TodoModel> todos) {
    Map<DateTime, int> createdTasks = {};

    for (var todo in todos) {
      if (todo.createdAt != null) {
        DateTime date = DateTime(
          todo.createdAt!.year,
          todo.createdAt!.month,
          todo.createdAt!.day,
        );

        if (createdTasks.containsKey(date)) {
          createdTasks[date] = createdTasks[date]! + 1;
        } else {
          createdTasks[date] = 1;
        }
      }
    }

    return createdTasks;
  }

  void filterTodosByDate(DateTime date) {
    filteredTodos.value = todos.where((todo) {
      if (todo.createdAt == null) return false;

      final todoDate = DateTime(
        todo.createdAt!.year,
        todo.createdAt!.month,
        todo.createdAt!.day,
      );
      final filterDate = DateTime(date.year, date.month, date.day);

      return todoDate == filterDate;
    }).toList();

    update();
  }

  void clearFilter() {
    filteredTodos.clear();
    update();
  }

  void deleteAllTodos() async {
    isLoading.value = true;

    var todosToDelete = List<TodoModel>.from(completedTodos);

    for (var todo in todosToDelete) {
      final result = await repository.delete(todo.id!);
      if (!result) {
        Get.snackbar('Error', 'Unable to delete task',
            colorText: Get.theme.snackBarTheme.actionTextColor,
            backgroundColor: Get.theme.snackBarTheme.backgroundColor);
      } else {
        todos.removeWhere((completedTodo) => completedTodo.id == todo.id);
        completedTodos.removeWhere(
          (todoCompleted) => todoCompleted.id == todo.id,
        );
      }
    }

    isLoading.value = false;
    update();

    Get.snackbar('Success', 'You have deleted completed tasks',
        colorText: Colors.white, backgroundColor: Colors.green);
  }

  void toggleFilterByDate() {
    filterByDate.value = !filterByDate.value;

    todos.sort((a, b) => filterByDate.value
        ? b.createdAt!.compareTo(a.createdAt!)
        : a.createdAt!.compareTo(b.createdAt!));

    update();
  }
}
