import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheduler/models/task.dart';

import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'package:scheduler/pages/home/tasks/create_task.dart';
import 'package:scheduler/pages/home/groups/create_group.dart';

import 'package:scheduler/pages/home/home.dart';
import 'package:scheduler/pages/calendar/calendar.dart';
import 'package:scheduler/pages/search/search.dart';
import 'package:scheduler/pages/settings/settings.dart';
import 'package:scheduler/pages/settings/auth/login.dart';
import 'package:scheduler/pages/settings/auth/register.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('user');
  await Hive.openBox('tasks');
  await Hive.openBox('groups');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Планировщик',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru')
      ],
      locale: const Locale('ru'),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/search': (BuildContext context) => const SearchPage(),
        '/calendar': (BuildContext context) => const CalendarPage(),
        '/settings': (BuildContext context) => const SettingsPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/create_task': (BuildContext context) => const CreateTaskPage(),
        '/create_group': (BuildContext context) => const CreateGroupPage(),
      },
    );
  }
}