import 'package:bot_dashboard/app/export_app.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 8.0,
        backgroundColor: AppConfig().appBarColor,
        title: const Text('Configuración'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await LoginService().signOut();
              } catch (e) {
                if (kDebugMode) {
                  print('Error al cerrar sesión: $e');
                }
                // Opcional: mostrar un mensaje de error al usuario.
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFormCard(
              context,
              'API de Gemini',
              GeminisForm(),
            ),
            _buildFormCard(
              context,
              'Preferencias de Usuario',
              AppConfigForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context, String title, Widget form) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(child: form),
          ],
        ),
      ),
    );
  }
}
