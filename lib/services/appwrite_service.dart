import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../data/models/swim_log.dart'; // Asegúrate que la ruta sea correcta

class AppwriteService {
  static final client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1') // 🌐 Reemplaza por tu endpoint real
    ..setProject('6801bdc90018796ede80');            // 🔧 Reemplaza por tu ID de proyecto

  static final databases = Databases(client);

  static const databaseId = '6801be7a000c4d5a1b05';     // 🗃️ ID de tu base de datos
  static const collectionId = '6801be86001622b52004';    // 📁 ID de tu colección

  // ✔️ Registrar un log con fecha personalizada (opcional)
  static Future<void> addSwimLog(DateTime date, bool didSwim, String message) async {
    await databases.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: ID.unique(),
      data: {
        'date': date.toIso8601String(),
        'didSwim': didSwim,
        'message': message,
      },
    );
  }

  // ✔️ Registrar un log con la fecha actual
  static Future<bool> addLog({required bool didSwim, required String message}) async {
    try {
      final now = DateTime.now().toIso8601String();
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          'date': now,
          'didSwim': didSwim,
          'message': message,
        },
      );
      return true;
    } catch (e) {
      print('Error al guardar log: $e');
      return false;
    }
  }

  // ✔️ Obtener todos los registros y convertirlos a SwimLog
  static Future<List<SwimLog>> getAllLogs() async {
    final response = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
    );

    return response.documents
        .map((doc) => SwimLog.fromMap(doc.data))
        .toList();
  }
}
