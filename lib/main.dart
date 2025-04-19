import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:coachfit_ai/services/health_service.dart';
import 'package:coachfit_ai/presentation/pages/mood_selection_page.dart';
import 'package:coachfit_ai/data/screens/add_swim_log_screen.dart'; // 👈 Importa la nueva pantalla

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  tz.initializeTimeZones();

  runApp(MyApp());
  scheduleDailyNotification();
}

void scheduleDailyNotification() async {
  bool hasSwumToday = await HealthService.wasThereSwimmingActivityToday();

  String message = hasSwumToday
      ? "¡Buen trabajo hoy! Seguí así. 🏊‍♂️"
      : "¡Es hora de volver al agua! Hoy es un buen día para nadar. 💧";

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Motivación para nadadores',
    message,
    _nextInstanceOfTenAM(),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_motivation_channel_id',
        'Motivación Diaria',
        channelDescription: 'Recordatorios diarios para deportistas',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

tz.TZDateTime _nextInstanceOfTenAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoachFit AI - Natación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MoodSelectionPage(),
        '/add': (context) => const AddSwimLogScreen(), // 👈 Ruta agregada
      },
    );
  }
}
