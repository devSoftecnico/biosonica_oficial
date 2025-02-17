/// Modelo para representar un archivo de audio.
class AudioFile {
  final String title;
  final String audioUrl;

  AudioFile({required this.title, required this.audioUrl});
}

/// Modelo para representar el contenido de una carpeta:
/// nombre de la carpeta, URL de la portada y lista de audios.
class FolderContentModel {
  final String folderName;
  final String? coverUrl;
  final List<AudioFile> audios;
  final int totalAudios;
  final double totalMinutes;

  FolderContentModel({
    required this.folderName,
    required this.coverUrl,
    required this.audios,
    required this.totalAudios,
    required this.totalMinutes,
  });
}
