import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../utils/utils_colors.dart';
import '../home/controller/home_controller.dart';
import '../home/page/list_item.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.green,
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.localizations
                                                .completedTasksHeader(
                                              controller.completedTodos.length,
                                            ),
                                            style: const TextStyle(
                                              height: 0,
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            context.localizations
                                                .taskCompletedText(
                                              controller
                                                  .userProvider.userName.value
                                                  .split(' ')
                                                  .first,
                                            ),
                                            style: const TextStyle(
                                              height: 0,
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      controller.completedTodos.isEmpty
                                          ? const SizedBox.shrink()
                                          : Switch(
                                              trackOutlineColor:
                                                  const WidgetStatePropertyAll<
                                                      Color?>(
                                                Colors.grey,
                                              ),
                                              inactiveThumbColor: Colors.grey,
                                              inactiveTrackColor: Colors.white,
                                              activeColor: Colors.green,
                                              activeTrackColor: Colors.white,
                                              thumbIcon:
                                                  const WidgetStatePropertyAll<
                                                      Icon?>(
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              value: controller
                                                  .isCalendarShown.value,
                                              onChanged: (value) => controller
                                                  .toggleCalendarShown(),
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    context.localizations.calendarPrompt,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
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
      floatingActionButton: controller.completedTodos.isEmpty
          ? null
          : FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 238, 66, 54),
              icon: const Icon(Icons.delete_sweep_sharp, color: Colors.white),
              onPressed: () => controller.deleteAllTodos(),
              label: Text(
                context.localizations.deleteAllTasksButton,
                style: const TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}

class ListViewAndCalendar extends StatelessWidget {
  const ListViewAndCalendar({
    super.key,
    required this.controller,
  });

  final HomeController controller;

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
                  controller.getCompletedTasksByDate(controller.completedTodos);
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
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const CircularProgressIndicator(),
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
                      ),
                    )
                  : GetBuilder<HomeController>(builder: (controller) {
                      return controller.completedTodos.isEmpty
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      context.localizations.noTasksText,
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
                                        top: 30,
                                        bottom: kBottomNavigationBarHeight * 2),
                                    shrinkWrap: true,
                                    itemCount: controller.completedTodos.length,
                                    itemBuilder: (context, index) {
                                      final todo =
                                          controller.completedTodos[index];

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
