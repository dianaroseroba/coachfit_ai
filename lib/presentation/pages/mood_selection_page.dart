import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/openai_service.dart';
import '../widgets/motivation_card.dart';

class MoodSelectionPage extends StatefulWidget {
  @override
  _MoodSelectionPageState createState() => _MoodSelectionPageState();
}

class _MoodSelectionPageState extends State<MoodSelectionPage> {
  final List<String> moods = ['Motivado', 'Cansado', 'Ansioso', 'Enfocado'];
  String? lastMood;

  @override
  void initState() {
    super.initState();
    _loadLastMood();
  }

  Future<void> _loadLastMood() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastMood = prefs.getString('last_mood');
    });
  }

  Future<void> _saveLastMood(String mood) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_mood', mood);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('¿Cómo te sientes hoy?'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          if (lastMood != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Último estado seleccionado: $lastMood',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: moods.length,
              itemBuilder: (context, index) {
                final mood = moods[index];
                return ListTile(
                  leading: Icon(Icons.pool, color: Colors.lightBlue),
                  title: Text(mood),
                  onTap: () async {
                    await _saveLastMood(mood);
                    final message = await OpenAIService.getMotivationalMessage(mood);
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: MotivationCard(message: message),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cerrar"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
