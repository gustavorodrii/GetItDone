import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/home/controller/home_controller.dart';
import 'package:getitdone/app/features/profile/controller/profile_controller.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../streams/general_stream.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(repository: Get.find()),
      builder: (profileController) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.black,
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
                                  Text(
                                    controller.userProvider.userName.value,
                                    style: const TextStyle(
                                      height: 0,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.userProvider.userEmail.value,
                                    style: const TextStyle(
                                      height: 0,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                child: DropdownButton<String>(
                                  value:
                                      profileController.selectedLanguage.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      Locale newLocale = Locale(newValue);
                                      GeneralStream.setLanguage(newLocale);
                                      profileController.selectedLanguage.value =
                                          newValue;
                                    }
                                  },
                                  items: <DropdownMenuItem<String>>[
                                    DropdownMenuItem<String>(
                                      alignment: Alignment.center,
                                      value: 'en',
                                      child: Image.asset(
                                        'icons/flags/png250px/us.png',
                                        package: 'country_icons',
                                        width: 50,
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      alignment: Alignment.center,
                                      value: 'pt',
                                      child: Image.asset(
                                        'icons/flags/png250px/br.png',
                                        package: 'country_icons',
                                        width: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context
                                              .localizations.todoLengthMessage,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          controller.todos.length.toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context.localizations
                                              .completedLengthMessage,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          controller.completedTodos.length
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: kBottomNavigationBarHeight),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/lottie/fire.json', height: 100),
                      Text(
                        textAlign: TextAlign.center,
                        controller.todos[0].consecutiveDays == 1
                            ? context.localizations.consecutiveDay(
                                controller.todos[0].consecutiveDays.toString())
                            : context.localizations.consecutiveDays(
                                controller.todos[0].consecutiveDays.toString()),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
