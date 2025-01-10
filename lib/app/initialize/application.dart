import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/streams/general_stream.dart';
import 'package:getitdone/l10n/l10n.dart';
import '../routes/routes.dart';
import '../routes/routes_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GeneralStream.loadSavedLanguage();
    });

    // GeneralStream.languageStream.add(const Locale('en'));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    GeneralStream.languageStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
        stream: GeneralStream.languageStream.stream,
        builder: (context, snapshot) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Get It Done',
            getPages: RoutesPages.routes,
            initialRoute: Routes.splash,
            supportedLocales: L10n.all,
            locale: snapshot.data,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
              useMaterial3: true,
            ),
          );
        });
  }
}
