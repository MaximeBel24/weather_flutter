import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_meteo/views/weather_background.dart';
import 'package:flutter_meteo/views/weather_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Anglais
        Locale('fr', ''), // Français
      ],
      locale: const Locale('fr', ''),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          primaryColor: Colors.white,
          useMaterial3: true,
          unselectedWidgetColor: Colors.white),
      home: const WeatherBackground(),
    );
  }
}
