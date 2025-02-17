import 'package:bot_dashboard/app/export_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase a través de FirebaseService
  await FirebaseService().initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthNotifier>(
          create: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider<AudioProvider>(
          create: (_) => AudioProvider(),
        ),
      ],
      child: MaterialApp(
        title: AppConfig().titleApp,
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        // Según el estado de autenticación, se mostrará Admin o Login
        home: Consumer<AuthNotifier>(
          builder: (context, auth, _) {
            return auth.isAuthenticated ? const Admin() : const Login();
          },
        ),
      ),
    );
  }
}
