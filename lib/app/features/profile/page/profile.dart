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
                color: Colors.black,
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
                                    controller.userProvider.userName.value
                                        .split(' ')
                                        .first,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      height: 0,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    profileController.topConsecutive.value
                                            ?.actualUser?.email ??
                                        "",
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
                          Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        context.localizations.todoLengthMessage,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
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
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        context.localizations
                                            .completedLengthMessage,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
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
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: profileController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Lottie.asset('assets/lottie/fire.json',
                                  height: 100),
                              profileController.topConsecutive.value?.actualUser
                                          ?.consecutiveDays ==
                                      0
                                  ? const SizedBox.shrink()
                                  : Text(
                                      textAlign: TextAlign.center,
                                      profileController
                                                  .topConsecutive
                                                  .value
                                                  ?.actualUser
                                                  ?.consecutiveDays ==
                                              1
                                          ? context.localizations
                                              .consecutiveDay(profileController
                                                  .topConsecutive
                                                  .value!
                                                  .actualUser!
                                                  .consecutiveDays
                                                  .toString())
                                          : context.localizations
                                              .consecutiveDays(profileController
                                                  .topConsecutive
                                                  .value!
                                                  .actualUser!
                                                  .consecutiveDays
                                                  .toString()),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              Text(
                                context.localizations.consecutiveDaysList,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              profileController
                                      .topConsecutive.value!.allUsers!.isEmpty
                                  ? Lottie.asset(
                                      'assets/lottie/empty_consecutivelist.json',
                                      height: 30)
                                  : Scrollbar(
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        shrinkWrap: true,
                                        itemCount: profileController
                                            .topConsecutive
                                            .value!
                                            .allUsers!
                                            .length,
                                        itemBuilder: (context, index) {
                                          var consecutiveProfile =
                                              profileController.topConsecutive
                                                  .value!.allUsers![index];
                                          var top3 = index == 0 ||
                                              index == 1 ||
                                              index == 2;
                                          return ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            trailing: top3
                                                ? Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        consecutiveProfile
                                                            .consecutiveDays
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Lottie.asset(
                                                          'assets/lottie/fire.json',
                                                          height: 30),
                                                    ],
                                                  )
                                                : const Icon(
                                                    Icons.military_tech),
                                            title: Text(
                                              '${index + 1}º ${consecutiveProfile.name}',
                                              style: TextStyle(
                                                  fontWeight: top3
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 40),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: profileController.signOut,
                                child: Text(
                                  context.localizations.signOut,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
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
