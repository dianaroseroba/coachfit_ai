import 'package:flutter/material.dart';
import '../models/swim_log.dart';
import '../utils/mock_data.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Natación 🐬"),
        backgroundColor: Colors.lightBlue.shade700,
      ),
      body: ListView.builder(
        itemCount: mockSwimLogs.length,
        itemBuilder: (context, index) {
          final log = mockSwimLogs[index];
          return Card(
            color: log.didSwim ? Colors.lightBlue[100] : Colors.grey[200],
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              leading: Icon(
                log.didSwim ? Icons.water : Icons.snooze,
                color: log.didSwim ? Colors.blue : Colors.grey,
              ),
              title: Text(
                DateFormat('EEEE, dd MMM yyyy', 'es').format(log.date),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(log.message),
            ),
          );
        },
      ),

      // 👇 FAB que navega a AddSwimLogScreen
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        backgroundColor: Colors.lightBlue.shade700,
        child: const Icon(Icons.add),
      ),
    );
  }
}
