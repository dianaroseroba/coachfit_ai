import 'package:health/health.dart';

class HealthService {
  static final Health health = Health();

  static Future<bool> wasThereSwimmingActivityToday() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    final types = <HealthDataType>[
      HealthDataType.WORKOUT,
    ];

    final permissions = <HealthDataAccess>[
      HealthDataAccess.READ,
    ];

    // Solicitar permisos
    bool accessWasGranted = await health.requestAuthorization(types, permissions: permissions);
    if (!accessWasGranted) return false;

    // Obtener los datos desde ayer hasta ahora
    final data = await health.getHealthDataFromTypes(
      startTime: yesterday,
      endTime: now,
      types: types,
    );

    for (var d in data) {
      if (d.value.toString().toLowerCase().contains("swim")) {
        return true;
      }
    }

    return false;
  }
}
