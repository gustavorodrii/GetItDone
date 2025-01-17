import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/home/controller/home_controller.dart';
import 'package:getitdone/app/features/home/page/list_item.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../models/todo_model.dart';
import '../../../service/notification_service.dart';
import '../../../shared/components/input_textfield.dart';

import '../../../utils/utils_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: MediaQuery.of(context).size.height / 5,
              color: Colors.blue,
              child: SafeArea(
                bottom: false,
                child: Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.localizations.greeting,
                                  style: const TextStyle(
                                    height: 0,
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${controller.userProvider.userName.value.split(' ').first}.',
                                  style: const TextStyle(
                                    height: 0,
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            controller.todos.isEmpty
                                ? const SizedBox.shrink()
                                : Switch(
                                    trackOutlineColor:
                                        const WidgetStatePropertyAll<Color?>(
                                      Colors.grey,
                                    ),
                                    inactiveThumbColor: Colors.grey,
                                    inactiveTrackColor: Colors.white,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.white,
                                    thumbIcon:
                                        const WidgetStatePropertyAll<Icon?>(
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: controller.isCalendarShown.value,
                                    onChanged: (value) =>
                                        controller.toggleCalendarShown(),
                                  ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.localizations.newTask,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () => createNewTask(),
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            ListViewAndCalendar(controller: controller),
          ],
        );
      }),
    );
  }

  Future<dynamic> createNewTask() {
    DateTime initialDate = DateTime.now().add(const Duration(days: 1));
    TimeOfDay initialTime = const TimeOfDay(hour: 9, minute: 0);
    controller.selectedDate.value = initialDate;
    controller.selectedTime.value = initialTime;
    controller.reminderSelected.value = false;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20)
                  .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  InputTextfield(
                    labelText: context.localizations.taskTitle,
                    controller: controller.taskNameController,
                    icon: Icons.task,
                    initialObscureText: false,
                  ),
                  InputTextfield(
                    labelText: context.localizations.taskDescription,
                    controller: controller.taskDescriptionController,
                    icon: Icons.description,
                    initialObscureText: false,
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Checkbox(
                          activeColor: Colors.blue,
                          value: controller.reminderSelected.value,
                          onChanged: (value) {
                            controller.reminderSelected.value = value!;
                          },
                        );
                      }),
                      Text(context.localizations.taskNotification),
                    ],
                  ),
                  Obx(() {
                    return controller.reminderSelected.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${context.localizations.taskData}: ${controller.selectedDate.value?.toLocal().toString().split(' ')[0]}',
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        DateTime? picked = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (picked != null &&
                                            picked !=
                                                controller.selectedDate.value) {
                                          controller.selectedDate.value =
                                              picked;
                                        }
                                      },
                                      icon: const Icon(Icons.calendar_today)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${context.localizations.taskTime}: ${controller.selectedTime.value?.format(context)}',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.access_time),
                                    onPressed: () async {
                                      TimeOfDay? picked = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            controller.selectedTime.value!,
                                      );
                                      if (picked != null &&
                                          picked !=
                                              controller.selectedTime.value) {
                                        controller.selectedTime.value = picked;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox();
                  }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (controller.taskNameController.text.trim().isEmpty) {
                        Get.snackbar(
                          context.localizations.error,
                          context.localizations.taskTitleRequired,
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                        return;
                      }

                      DateTime? reminderDate = controller.reminderSelected.value
                          ? DateTime(
                              controller.selectedDate.value!.year,
                              controller.selectedDate.value!.month,
                              controller.selectedDate.value!.day,
                              controller.selectedTime.value!.hour,
                              controller.selectedTime.value!.minute,
                            )
                          : null;
                      TodoModel newTodo = TodoModel(
                        title: controller.taskNameController.text,
                        description: controller.taskDescriptionController.text,
                        completed: false,
                        reminder: reminderDate,
                      );
                      controller.create(newTodo);
                      if (reminderDate != null) {
                        await NotificationService.scheduleNotification(
                          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                          title: context.localizations.taskReminder,
                          body: newTodo.title,
                          scheduledDate: reminderDate,
                        );
                      }
                    },
                    child: Obx(() {
                      return controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(context.localizations.addTask,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold));
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ListViewAndCalendar extends StatefulWidget {
  const ListViewAndCalendar({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<ListViewAndCalendar> createState() => _ListViewAndCalendarState();
}

class _ListViewAndCalendarState extends State<ListViewAndCalendar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<HomeController>(builder: (controller) {
              Map<DateTime, int> completedTasks =
                  controller.getCreatedTasksByDate(controller.todos);
              return Visibility(
                visible: controller.isCalendarShown.value,
                child: controller.todos.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Column(
                          children: [
                            HeatMapCalendar(
                              datasets: completedTasks,
                              colorMode: ColorMode.color,
                              defaultColor: Colors.grey[300]!,
                              textColor: Colors.black,
                              colorsets: UtilsColors.heatMapColorSets,
                              monthFontSize: 14,
                              weekFontSize: 14,
                              showColorTip: false,
                              onClick: (date) {
                                controller.filterTodosByDate(date);
                              },
                            ),
                            TextButton(
                              onPressed: () => controller.clearFilter(),
                              child: Text(
                                context.localizations.calendar,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }),
            const SizedBox(height: 20),
            widget.controller.todos.isEmpty || widget.controller.isLoading.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        widget.controller.toggleFilterByDate();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.swap_calls,
                            size: 30,
                            color: Colors.blue,
                          ),
                          Text(
                            widget.controller.filterByDate.value
                                ? context.localizations.oldestList
                                : context.localizations.newestList,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Obx(
              () => widget.controller.isLoading.value
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                          Text(
                            context.localizations.loadingData,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ))
                  : GetBuilder<HomeController>(builder: (controller) {
                      return controller.todos.isEmpty
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      context.localizations.noTasks,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Lottie.asset(
                                      height: 200,
                                      'assets/lottie/empty_list.json',
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.white,
                                    ],
                                    stops: [.0, .1],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: Scrollbar(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: kBottomNavigationBarHeight),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.filteredTodos.isNotEmpty
                                            ? controller.filteredTodos.length
                                            : controller.todos.length,
                                    itemBuilder: (context, index) {
                                      final todo =
                                          controller.filteredTodos.isNotEmpty
                                              ? controller.filteredTodos[index]
                                              : controller.todos[index];

                                      return ListItem(
                                        todo: todo,
                                        controller: controller,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
