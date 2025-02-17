import 'package:bot_dashboard/app/export_app.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final String? photoUrl;
  final String? displayName;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.photoUrl,
    this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueGrey : Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isUser) ...[
                  SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: context.read<ChatViewModel>().isLoading ? const CircularProgressIndicator(strokeWidth: 2.0) : const Icon(Icons.smart_toy, size: 16.0),
                  ),
                  const SizedBox(width: 4.0),
                  const Text(
                    "Biosónica Asistente",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (photoUrl != null)
                  CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 8.0,
                    child: ClipOval(
                      child: photoUrl != null
                          ? Image.network(
                              photoUrl!,
                              width: 16.0,
                              height: 16.0,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 16.0);
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const SizedBox(
                                  width: 16.0,
                                  height: 16.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              },
                              cacheWidth: 32, // Cache a small version
                              cacheHeight: 32,
                              headers: const {
                                'Cache-Control': 'max-age=3600', // Cache for 1 hour
                              },
                            )
                          : const Icon(Icons.person, size: 16.0),
                    ),
                  ),
                if (displayName != null) ...[
                  const SizedBox(width: 4.0),
                  Text(
                    displayName!,
                    style: TextStyle(
                      color: isUser ? Colors.white70 : Colors.black54,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Wrap(
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  DateFormat('HH:mm').format(timestamp),
                  style: TextStyle(
                    color: isUser ? Colors.white70 : Colors.white54,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
