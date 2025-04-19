import 'package:flutter/material.dart';
import 'mood_selection_page.dart';
import '../../data/screens/history_screen.dart'; // Asegúrate de importar esta pantalla

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CoachFit AI - Bienvenido Nadador')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Elige tu estado de ánimo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MoodSelectionPage()),
                );
              },
            ),
            const SizedBox(height: 20), // Espacio entre botones
            ElevatedButton(
              child: Text('Ver Historial de Natación 🏊‍♂️'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
