import 'package:bot_dashboard/app/export_app.dart';
import 'package:intl/intl.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.smart_toy_outlined,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (message.isUser && message.photoUrl != null) ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(message.photoUrl!),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blueGrey : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.displayName != null) ...[
                    Text(
                      message.displayName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: message.isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      color: message.isUser ? Colors.white.withAlpha(7) : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser && message.photoUrl == null) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(
                Icons.person_outline,
                color: Colors.grey,
                size: 24,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
