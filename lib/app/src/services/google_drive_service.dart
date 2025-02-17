// import 'package:bot_dashboard/app/export_app.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'package:intl/intl.dart';

// class GoogleDriveService {
//   static const _scopes = [drive.DriveApi.driveFileScope];
//   late final drive.DriveApi _driveApi;

//   Future<void> initialize() async {
//     try {
//       http.Client client;
//       if (kIsWeb) {
//         // For web, use the default auth client
//         final googleUser = await GoogleSignIn().signInSilently();
//         if (googleUser == null) throw Exception('No user signed in');

//         final googleAuth = await googleUser.authentication;
//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//         final idToken = await userCredential.user?.getIdToken();
//         if (idToken == null) throw Exception('Failed to get ID token');

//         client = http.Client();
//       } else {
//         // For other platforms, use service account
//         final credentials = ServiceAccountCredentials.fromJson(
//           await File('lib/assets/credentials.json').readAsString(),
//         );
//         client = await clientViaServiceAccount(credentials, _scopes);
//       }
//       _driveApi = drive.DriveApi(client);
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error initializing Google Drive service: $e');
//       }
//       rethrow;
//     }
//   }

//   Future<String> uploadProfilePicture(String displayName, String imagePath) async {
//     try {
//       final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
//       final folderName = '${displayName}_$timestamp';

//       // Create folder
//       final folderMetadata = drive.File()
//         ..name = folderName
//         ..mimeType = 'application/vnd.google-apps.folder';

//       final folder = await _driveApi.files.create(folderMetadata);

//       // Upload image
//       final imageFile = File(imagePath);
//       final imageMetadata = drive.File()
//         ..name = path.basename(imagePath)
//         ..parents = [folder.id!];

//       final media = drive.Media(
//         imageFile.openRead(),
//         await imageFile.length(),
//       );

//       final uploadedFile = await _driveApi.files.create(
//         imageMetadata,
//         uploadMedia: media,
//       );

//       // Make the file publicly accessible
//       await _driveApi.permissions.create(
//         drive.Permission()
//           ..type = 'anyone'
//           ..role = 'reader',
//         uploadedFile.id!,
//       );

//       // Get the web view link
//       final file = await _driveApi.files.get(
//         uploadedFile.id!,
//         $fields: 'webViewLink',
//       ) as drive.File;

//       return file.webViewLink ?? '';
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error uploading profile picture: $e');
//       }
//       rethrow;
//     }
//   }
// }
