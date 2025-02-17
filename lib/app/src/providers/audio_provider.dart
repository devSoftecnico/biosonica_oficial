import 'package:bot_dashboard/app/export_app.dart';

class AudioProvider extends ChangeNotifier {
  List<FolderContentModel> _folderContents = [];

  List<FolderContentModel> get folderContents => _folderContents;

  Future<void> loadFolders() async {
    try {
      final googleService = GoogleService();
      final folderContentsFromService = await googleService.getAllFolderContents();
      _folderContents = folderContentsFromService.map((folderContent) {
        final folderName = folderContent.folder.name ?? 'Unknown Folder';
        final coverUrl = folderContent.coverImage?.webViewLink;
        final audios = folderContent.audios.map((audioFile) {
          return AudioFile(
            title: audioFile.name ?? 'Unknown Track',
            audioUrl: audioFile.webContentLink ?? '',
          );
        }).toList();
        return FolderContentModel(
          folderName: folderName,
          coverUrl: coverUrl,
          audios: audios,
          totalAudios: folderContent.totalAudios,
          totalMinutes: folderContent.totalMinutes,
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error al cargar carpetas: $e");
      }
    }
  }
}
