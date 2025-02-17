import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:bot_dashboard/app/export_app.dart';

class FolderContent {
  final drive.File folder;
  final drive.File? coverImage;
  final List<drive.File> audios;
  final int totalAudios;
  final double totalMinutes;

  FolderContent({
    required this.folder,
    required this.coverImage,
    required this.audios,
    required this.totalAudios,
    required this.totalMinutes,
  });
}

class GoogleService {
  static const String parentFolderId = "1RjUijQMs5mSMcU-r4ch8x4Rs6dxdEnYA";

  static final GoogleService _instance = GoogleService._internal();
  drive.DriveApi? _driveApi;

  GoogleService._internal();

  factory GoogleService() => _instance;

  Future<drive.DriveApi> get driveApi async {
    if (_driveApi == null) {
      final credentialsJson = await rootBundle.loadString('lib/assets/credentials.json');
      final accountCredentials = auth.ServiceAccountCredentials.fromJson(credentialsJson);
      final scopes = [drive.DriveApi.driveReadonlyScope];
      final client = await auth.clientViaServiceAccount(accountCredentials, scopes);
      _driveApi = drive.DriveApi(client);
    }
    return _driveApi!;
  }

  Future<List<drive.File>> getFolders() async {
    final api = await driveApi;
    final query = "'$parentFolderId' in parents and mimeType = 'application/vnd.google-apps.folder'";
    final fileList = await api.files.list(q: query, orderBy: "name");
    return fileList.files ?? [];
  }

  Future<List<String>> getImageUrls(String folderId) async {
    final api = await driveApi;
    final query = "'$folderId' in parents and mimeType contains 'image'";
    final fileList = await api.files.list(q: query);
    return fileList.files?.map((file) => file.webViewLink ?? '').toList() ?? [];
  }

  Future<drive.File?> getCoverImage(String folderId) async {
    final api = await driveApi;
    final query = "'$folderId' in parents and (name = 'portada.jpg' or name = 'portada.jpeg')";
    final fileList = await api.files.list(q: query);
    return fileList.files?.isNotEmpty == true ? fileList.files!.first : null;
  }

  Future<List<drive.File>> getAudios(String folderId) async {
    final api = await driveApi;
    final query = "'$folderId' in parents and mimeType contains 'audio'";
    final fileList = await api.files.list(q: query, orderBy: "name");
    return fileList.files ?? [];
  }

  Future<int> getTotalAudios(String folderId) async {
    final api = await driveApi;
    final query = "'$folderId' in parents and mimeType contains 'audio'";
    final fileList = await api.files.list(q: query);
    return fileList.files?.length ?? 0;
  }

  Future<double> getTotalAudioMinutes(String folderId) async {
    final audios = await getAudios(folderId);
    double totalSeconds = 0;
    for (var audio in audios) {
      if (audio.appProperties != null && audio.appProperties!.containsKey("duration")) {
        totalSeconds += double.tryParse(audio.appProperties!["duration"] ?? "0") ?? 0;
      }
    }
    return totalSeconds / 60;
  }

  Future<FolderContent> getFolderContent(drive.File folder) async {
    final folderId = folder.id!;

    final coverImage = await getCoverImage(folderId);
    final audios = await getAudios(folderId);
    final totalMinutes = await getTotalAudioMinutes(folderId);
    final totalAudios = audios.length;

    if (kDebugMode) {
      print("=== Carpeta: ${folder.name} ===");
    }
    if (kDebugMode) {
      print("Portada encontrada: ${coverImage?.webViewLink}");
    }
    if (kDebugMode) {
      print("Total audios: $totalAudios");
    }

    for (var audio in audios) {
      if (kDebugMode) {
        print("Audio encontrado: ${audio.name}, URL: ${audio.webContentLink}");
      }
    }

    return FolderContent(
      folder: folder,
      coverImage: coverImage,
      audios: audios,
      totalAudios: totalAudios,
      totalMinutes: totalMinutes,
    );
  }

  Future<List<FolderContent>> getAllFolderContents() async {
    final folders = await getFolders();
    final contents = await Future.wait(
      folders.map((folder) => getFolderContent(folder)),
    );
    return contents;
  }
}
