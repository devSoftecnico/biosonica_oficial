import 'package:bot_dashboard/app/export_app.dart';

class LoginService {
  final FirebaseService _firebaseService = FirebaseService();

  final UserService _userService = UserService();

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser;

      if (kIsWeb) {
// Para web se intenta primero signInSilently.

        googleUser = await _firebaseService.googleSignIn.signInSilently();

        googleUser ??= await _firebaseService.googleSignIn.signIn();
      } else {
// En plataformas móviles se utiliza signIn normalmente.

        googleUser = await _firebaseService.googleSignIn.signIn();
      }

      if (googleUser == null) return; // El usuario canceló el inicio de sesión.

      await _processGoogleUser(googleUser);
    } catch (e) {
      if (kDebugMode) {
        print('Error en inicio de sesión con Google: $e');
      }

      rethrow;
    }
  }

  Future<void> _processGoogleUser(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseService.auth.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
// Crea o actualiza el registro del usuario en Firestore.

      await _userService.createOrUpdateUser(
        displayName: user.displayName ?? 'Sin Nombre',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
      );
    }
  }

  Future<void> signOut() async {
    try {
// Obtenemos el usuario actual para actualizar la fecha de logout.

      final User? user = _firebaseService.auth.currentUser;

      if (user != null && user.email != null) {
        await _userService.updateLogoutDate(user.email!);
      }

      await _firebaseService.auth.signOut();

      await _firebaseService.googleSignIn.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error al cerrar sesión: $e');
      }

      rethrow;
    }
  }
}
