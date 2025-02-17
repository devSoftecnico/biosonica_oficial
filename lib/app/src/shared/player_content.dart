import 'package:bot_dashboard/app/export_app.dart';

class PlayerContent extends StatefulWidget {
  const PlayerContent({super.key});

  @override
  State<PlayerContent> createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent> with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController _animationController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAudioLoaded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simula un pequeño retraso

    if (!mounted) return; // Verifica si el widget sigue montado

    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    if (!_isAudioLoaded && audioProvider.folderContents.isNotEmpty) {
      final firstFolder = audioProvider.folderContents.first;
      if (firstFolder.audios.isNotEmpty && firstFolder.audios.first.audioUrl.isNotEmpty) {
        try {
          await _audioPlayer.setUrl(firstFolder.audios.first.audioUrl);
          if (!mounted) return; // Evita llamar a setState si el widget fue desmontado
          setState(() {
            _isAudioLoaded = true;
          });
        } catch (error) {
          if (kDebugMode) {
            print("Error setting audio source: $error");
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      _audioPlayer.play();
      _animationController.repeat();
    } else {
      _audioPlayer.pause();
      _animationController.stop();
    }
  }

  void _showPlaylist() {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    if (audioProvider.folderContents.isEmpty) return;
    final firstFolder = audioProvider.folderContents.first;
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Playlist',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${firstFolder.folderName} - (${firstFolder.audios.length} audios)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: firstFolder.audios.length,
                itemBuilder: (context, index) {
                  final audio = firstFolder.audios[index];
                  return ListTile(
                    leading: const Icon(Icons.music_note),
                    title: Text(audio.title),
                    subtitle: Text(firstFolder.folderName),
                    onTap: () async {
                      if (audio.audioUrl.isNotEmpty) {
                        await _audioPlayer.setUrl(audio.audioUrl);
                        setState(() {
                          isPlaying = true;
                        });
                        _audioPlayer.play();
                        _animationController.repeat();
                        Navigator.pop(context);
                      } else {
                        if (kDebugMode) {
                          print("URL del audio es nula o vacía.");
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final hasFolders = audioProvider.folderContents.isNotEmpty;
    final firstFolder = hasFolders ? audioProvider.folderContents.first : null;

    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(1), blurRadius: 8, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey[300]),
            child: hasFolders && firstFolder!.coverUrl != null ? Image.network(firstFolder.coverUrl!, fit: BoxFit.cover) : const Icon(Icons.music_note, color: Colors.grey),
          ),
          Expanded(
            child: Marquee(
              text: hasFolders && firstFolder!.audios.isNotEmpty ? firstFolder.audios.first.title : 'No hay pistas disponibles',
              style: const TextStyle(fontWeight: FontWeight.w500),
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 30.0,
              pauseAfterRound: const Duration(seconds: 1),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isPlaying
                ? SizedBox(
                    width: 100,
                    height: 50,
                    child: Lottie.asset(
                      'lib/assets/lotties/wave5.json',
                      controller: _animationController,
                      onLoaded: (composition) {
                        _animationController.duration = composition.duration;
                        if (isPlaying) {
                          _animationController.repeat();
                        }
                      },
                    ),
                  )
                : const SizedBox(width: 0, height: 50),
          ),
          IconButton(icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow), onPressed: _togglePlayPause, color: Colors.teal[400]),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: _showPlaylist, color: Colors.grey[600]),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
