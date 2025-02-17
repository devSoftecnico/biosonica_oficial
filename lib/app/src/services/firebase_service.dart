import 'package:bot_dashboard/app/export_app.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final GoogleSignIn _googleSignIn;
  bool _initialized = false;

  // Constructor privado
  FirebaseService._internal();

  // Constructor singleton
  factory FirebaseService() {
    return _instance;
  }

  // Inicializa Firebase
  Future<void> initialize() async {
    if (!_initialized) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _googleSignIn = GoogleSignIn();
      _initialized = true;
    }
  }

  // Getters para las instancias de Firebase
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  GoogleSignIn get googleSignIn => _googleSignIn;
}
