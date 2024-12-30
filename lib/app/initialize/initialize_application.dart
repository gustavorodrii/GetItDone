import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getitdone/app/initialize/application.dart';
import 'package:getitdone/app/injections/injector.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../service/notification_service.dart';

void initializeApplication() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  tz.initializeTimeZones();
  await dotenv.load(fileName: '.env');
  Injector.init();
  runApp(const Application());
}
