import 'package:bot_dashboard/app/export_app.dart';

class AuthNotifier extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  AuthNotifier() {
    // Escucha los cambios en el estado de autenticación
    _firebaseService.auth.authStateChanges().listen((user) {
      _isAuthenticated = user != null;
      notifyListeners();
    });
  }

  // Método opcional para verificar manualmente el estado de autenticación
  Future<void> checkAuthStatus() async {
    final user = _firebaseService.auth.currentUser;
    _isAuthenticated = user != null;
    notifyListeners();
  }
}
