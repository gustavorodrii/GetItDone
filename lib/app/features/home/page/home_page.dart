import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/home/controller/home_controller.dart';
import 'package:getitdone/app/features/home/page/list_item.dart';
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                color: Colors.blue,
                child: SafeArea(
                  bottom: false,
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Olá, ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.userProvider.userName.value,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                trackOutlineColor:
                                    const WidgetStatePropertyAll<Color?>(
                                  Colors.grey,
                                ),
                                inactiveThumbColor: Colors.grey,
                                trackColor:
                                    const WidgetStatePropertyAll<Color?>(
                                  Colors.white,
                                ),
                                thumbColor:
                                    const WidgetStatePropertyAll<Color?>(
                                  Colors.blue,
                                ),
                                thumbIcon: const WidgetStatePropertyAll<Icon?>(
                                  Icon(
                                    Icons.calendar_month,
                                  ),
                                ),
                                value: controller.isCalendarShown.value,
                                onChanged: (value) =>
                                    controller.toggleCalendarShown(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Crie uma nova tarefa\npara organizar suas atividades',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () => createNewTask(context),
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 220,
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
                          controller.getCompletedTasksByDate(controller.todos);
                      return Visibility(
                        visible: controller.isCalendarShown.value,
                        child: Container(
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
                                child: const Text(
                                  'Limpar filtro',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  Text(
                                    'Estamos carregando os seus dados, aguarde um instante por favor!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Que tal começar a criar as suas tarefas e manter a sua vida organizada ?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Lottie.asset(
                                              height: 300,
                                              'assets/lottie/empty_list.json',
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 20),
                                        shrinkWrap: true,
                                        itemCount: controller
                                                .filteredTodos.isNotEmpty
                                            ? controller.filteredTodos.length
                                            : controller.todos.length,
                                        itemBuilder: (context, index) {
                                          final todo = controller
                                                  .filteredTodos.isNotEmpty
                                              ? controller.filteredTodos[index]
                                              : controller.todos[index];

                                          return ListItem(
                                            todo: todo,
                                            controller: controller,
                                          );
                                        },
                                      ),
                                    );
                            }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> createNewTask(BuildContext context) {
    DateTime initialDate = DateTime.now().add(const Duration(days: 1));
    TimeOfDay initialTime = const TimeOfDay(hour: 9, minute: 0);
    controller.selectedDate.value = initialDate;
    controller.selectedTime.value = initialTime;
    controller.reminderSelected.value = false;
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        showDragHandle: true,
        context: context,
        builder: (_) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputTextfield(
                    labelText: 'Nome da tarefa',
                    controller: controller.taskNameController,
                    icon: Icons.task,
                  ),
                  InputTextfield(
                    labelText: 'Descrição da tarefa',
                    controller: controller.taskDescriptionController,
                    icon: Icons.description,
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Checkbox(
                          value: controller.reminderSelected.value,
                          onChanged: (value) {
                            controller.reminderSelected.value = value!;
                          },
                        );
                      }),
                      const Text('Deseja receber notificação?'),
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
                                    'Data: ${controller.selectedDate.value?.toLocal().toString().split(' ')[0]}',
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
                                    'Hora: ${controller.selectedTime.value?.format(context)}',
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
                          title: 'Lembrete da Tarefa',
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
                          : const Text('Criar tarefa',
                              style: TextStyle(
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
