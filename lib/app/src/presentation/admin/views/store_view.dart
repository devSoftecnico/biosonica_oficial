import 'package:bot_dashboard/app/export_app.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<List<FolderContent>>(
        future: GoogleService().getAllFolderContents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          final folderContents = snapshot.data ?? [];
          if (folderContents.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron carpetas',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return _buildGridView(folderContents);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      elevation: 8.0,
      backgroundColor: AppConfig().appBarColor,
      title: const Text('Tienda'),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
      ],
    );
  }

  Widget _buildGridView(List<FolderContent> folderContents) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: folderContents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return _FolderCard(item: folderContents[index]);
            },
          ),
        );
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 800) return 3;
    if (width >= 600) return 2;
    return 1;
  }
}

class _FolderCard extends StatefulWidget {
  final FolderContent item;
  const _FolderCard({required this.item});

  @override
  State<_FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<_FolderCard> {
  late Future<List<String>> imageUrlsFuture;

  @override
  void initState() {
    super.initState();
    imageUrlsFuture = GoogleService().getImageUrls(widget.item.folder.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCoverImage(),
          _buildFolderInfo(),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return Expanded(
      child: FutureBuilder<List<String>>(
        future: imageUrlsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            return _placeholderImage();
          }
          final imageUrl = snapshot.data!.first;
          // Asegurarse de que la URL sea válida para mostrar la imagen desde Google Drive
          final validImageUrl = _getValidImageUrl(imageUrl);
          return Image.network(
            validImageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return _placeholderImage();
            },
          );
        },
      ),
    );
  }

  String _getValidImageUrl(String imageUrl) {
    // Asegurarse de que la URL sea válida para mostrar la imagen
    if (imageUrl.contains('drive.google.com')) {
      return imageUrl.replaceAll('drive.google.com', 'drive.google.com/uc?export=view');
    }
    return imageUrl;
  }

  Widget _placeholderImage() {
    return Container(
      color: Colors.black26,
      child: const Icon(Icons.broken_image, size: 40, color: Colors.white54),
    );
  }

  Widget _buildFolderInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.folder.name ?? 'Sin nombre',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.item.totalAudios} audios',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            '${widget.item.totalMinutes.toStringAsFixed(1)} minutos',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
