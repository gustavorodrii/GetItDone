import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getitdone/app/initialize/application.dart';
import 'package:getitdone/app/injections/injector.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
import '../service/notification_service.dart';

void initializeApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://cbf688bd74bf1b944caca7354d43bf05@o4508677444861952.ingest.us.sentry.io/4508677446238208';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () async {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        // Log do erro (opcional)
        // Retorna um widget genérico centralizado em vez de quebrar o app
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white, size: 64),
                SizedBox(height: 8),
                Text(
                  'Ocorreu um erro inesperado.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Por favor, tente novamente mais tarde ou entre em contato com o suporte.',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  details.toStringShort(),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      };
      await NotificationService.initialize();
      tz.initializeTimeZones();
      await dotenv.load(fileName: '.env');
      Injector.init();
      runApp(const Application());
    },
  );
}
