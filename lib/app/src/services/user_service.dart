import 'package:bot_dashboard/app/export_app.dart';

class UserService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('biosonica_cloud/account/users');

  Future<void> createOrUpdateUser({
    required String displayName,
    required String email,
    String? role,
    String? photoUrl,
  }) async {
    try {
      final userDoc = await _usersCollection.doc(email).get();
      final now = DateTime.now();
      if (!userDoc.exists) {
        // Crear nuevo usuario
        final newUser = UserModel(
          displayName: displayName,
          email: email,
          registrationDate: now,
          lastLoginDate: now,
          role: role ?? 'Usuario',
          photoUrl: photoUrl,
        );
        await _usersCollection.doc(email).set(newUser.toJson());
      } else {
        // Actualizar usuario existente
        final existingUser = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        final updatedUser = existingUser.copyWith(
          lastLoginDate: now,
          role: role,
          photoUrl: photoUrl,
        );
        await _usersCollection.doc(email).update(updatedUser.toJson());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en createOrUpdateUser: $e');
      }
      rethrow;
    }
  }

  Future<void> updateLogoutDate(String email) async {
    try {
      final userDoc = await _usersCollection.doc(email).get();
      if (userDoc.exists) {
        final existingUser = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        final updatedUser = existingUser.copyWith(
          lastLogoutDate: DateTime.now(),
        );
        await _usersCollection.doc(email).update(updatedUser.toJson());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en updateLogoutDate: $e');
      }
      rethrow;
    }
  }

  Future<UserModel?> getUserData(String email) async {
    try {
      final userDoc = await _usersCollection.doc(email).get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error en getUserData: $e');
      }
      rethrow;
    }
  }
}
