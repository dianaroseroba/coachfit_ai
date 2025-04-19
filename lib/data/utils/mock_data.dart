import '../models/swim_log.dart';

List<SwimLog> mockSwimLogs = [
  SwimLog(date: DateTime.now().subtract(Duration(days: 0)), didSwim: true, message: "¡Gran esfuerzo hoy! 🏊‍♂️"),
  SwimLog(date: DateTime.now().subtract(Duration(days: 1)), didSwim: false, message: "¡No te rindas! Mañana será mejor."),
  SwimLog(date: DateTime.now().subtract(Duration(days: 2)), didSwim: true, message: "¡Estás creando una racha! 💪"),
  SwimLog(date: DateTime.now().subtract(Duration(days: 3)), didSwim: false, message: "¡Vamos, el agua te espera! 💦"),
];
