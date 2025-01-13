import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const CarouselItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Expanded(
          child: Lottie.asset(
            imagePath,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class WelcomePage extends StatefulWidget {
  dynamic argumentData = Get.arguments;
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  void _prevItem() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _carouselController.previousPage();
    }
  }

  void _nextItem() {
    if (_currentIndex < 2) {
      setState(() {
        _currentIndex++;
      });
      _carouselController.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: kBottomNavigationBarHeight),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: context.localizations.welcomeToApp(
                          widget.argumentData.toString().split(' ').first),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: context.localizations.welcomePageMessage2,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: context.localizations.welcomePageMessage3,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    carouselController: _carouselController,
                    items: [
                      CarouselItem(
                        imagePath: 'assets/lottie/calendar.json',
                        title:
                            context.localizations.welcomePageMessageHomeTitle,
                        description: context
                            .localizations.welcomePageMessageHomeDescription,
                      ),
                      CarouselItem(
                        imagePath: 'assets/lottie/create.json',
                        title:
                            context.localizations.welcomePageMessageDoneTitle,
                        description: context
                            .localizations.welcomePageMessageDoneDescription,
                      ),
                      CarouselItem(
                        imagePath: 'assets/lottie/rank10.json',
                        title: context
                            .localizations.welcomePageMessageProfileTitle,
                        description: context
                            .localizations.welcomePageMessageProfileDescription,
                      ),
                    ],
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      aspectRatio: 16 / 16,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _prevItem,
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentIndex == index ? 12 : 8,
                            height: _currentIndex == index ? 12 : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => _nextItem(),
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                        ),
                        onPressed: _currentIndex == 2
                            ? () => Get.offAllNamed('/mainNavigation')
                            : null,
                        child: Text(
                          context.localizations.goToApp,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
