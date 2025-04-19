import 'package:flutter/material.dart';
import '../../services/appwrite_service.dart';
import 'package:intl/intl.dart';

class AddSwimLogScreen extends StatefulWidget {
  const AddSwimLogScreen({super.key});

  @override
  State<AddSwimLogScreen> createState() => _AddSwimLogScreenState();
}

class _AddSwimLogScreenState extends State<AddSwimLogScreen> {
  bool didSwim = false;
  final TextEditingController _messageController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitLog() async {
    setState(() => isLoading = true);

    final success = await AppwriteService.addLog(
      didSwim: didSwim,
      message: _messageController.text,
    );

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro guardado con éxito 🏊‍♂️")),
      );
      Navigator.pop(context); // Vuelve al historial
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al guardar el registro ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Registro"),
        backgroundColor: Colors.lightBlue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("¿Nadaste hoy?"),
              subtitle: Text(
                DateFormat('EEEE, dd MMM yyyy', 'es').format(DateTime.now()),
              ),
              value: didSwim,
              onChanged: (value) => setState(() => didSwim = value),
              activeColor: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: "Mensaje motivacional o comentario",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: isLoading ? null : _submitLog,
              icon: const Icon(Icons.save),
              label: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Guardar Registro"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue.shade700,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
