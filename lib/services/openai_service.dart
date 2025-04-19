class OpenAIService {
  static Future<String> getMotivationalMessage(String mood) async {
    // Simulación de una llamada a IA según estado de ánimo.
    await Future.delayed(Duration(seconds: 1));

    Map<String, String> responses = {
      'Motivado': '¡Sigue así, nadador! Hoy puedes batir tu propio récord.',
      'Cansado': 'Incluso los grandes nadadores descansan. Un paso a la vez.',
      'Ansioso': 'Respira, concéntrate en el agua, y confía en tu entrenamiento.',
      'Enfocado': 'Nada con determinación, cada brazada te acerca a la meta.',
    };

    return responses[mood] ?? '¡Tú puedes!';
  }
}
