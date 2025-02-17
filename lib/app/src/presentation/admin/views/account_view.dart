import 'package:bot_dashboard/app/export_app.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 8.0,
        backgroundColor: AppConfig().appBarColor,
        title: const Text('Mi cuenta'),
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
      body: const Center(
        child: Text('En construcción'),
      ),
    );
  }
}
