import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/register/controller/register_controller.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/components/input_textfield.dart';
import '../../../streams/general_stream.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    30,
                    kBottomNavigationBarHeight * 1.6,
                    30,
                    kBottomNavigationBarHeight),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/register.json'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            context.localizations.registerMessage,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    InputTextfield(
                      controller: controller.nameController,
                      labelText: context.localizations.inputNameLogin,
                      initialObscureText: false,
                      icon: Icons.lock,
                    ),
                    InputTextfield(
                      controller: controller.emailController,
                      labelText: context.localizations.inputEmailLogin,
                      icon: Icons.email,
                      initialObscureText: false,
                    ),
                    InputTextfield(
                      controller: controller.passwordController,
                      labelText: context.localizations.inputPasswordLogin,
                      initialObscureText: true,
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 10),
                    controller.isLoading.value
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue),
                          )
                        : Row(
                            spacing: 25,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Colors.blue,
                                        width: 1,
                                      )),
                                  onPressed: () => Get.offAllNamed('/login'),
                                  child: Text(
                                      context.localizations.alreadyHaveAccess),
                                ),
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () => controller.register(
                                  name: controller.nameController.text,
                                  email: controller.emailController.text,
                                  password: controller.passwordController.text,
                                  context: context,
                                ),
                                child: Text(context.localizations.register),
                              )),
                            ],
                          ),
                  ],
                ),
              ),
              Positioned(
                top: kToolbarHeight * 1.5,
                right: 30,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedLanguage.value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        Locale newLocale = Locale(newValue);
                        GeneralStream.setLanguage(newLocale);
                        controller.selectedLanguage.value = newValue;
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
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
