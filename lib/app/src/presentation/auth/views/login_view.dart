import 'package:bot_dashboard/app/export_app.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo: Lottie que ocupa todo el espacio con opacidad.
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Ajusta el valor de opacidad (0.0 a 1.0)
              child: Lottie.asset(
                'lib/assets/lotties/wave3.json',
                alignment: Alignment.center,
                fit: BoxFit.cover,
                reverse: true,
              ),
            ),
          ),
          // Contenido principal centrado.
          Center(
            child: Column(
              children: [
                TitleApp(),
                TextPadding(
                  text: AppConfig().info,
                  bottom: 8.0,
                  semanticsLabel: AppConfig().info,
                ),
                CustomElevatedButton(
                  height: 50.0,
                  imagePath: AppConfig().google,
                  text: AppConfig().sesion,
                  semanticsLabel: AppConfig().sesion,
                  semanticLabelImage: AppConfig().google,
                  onPressed: () async {
                    try {
                      await LoginService().signInWithGoogle();
                    } catch (e) {
                      if (kDebugMode) {
                        print('Error en el proceso de inicio de sesión: $e');
                      }
                      // Opcional: Mostrar un mensaje de error al usuario.
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
