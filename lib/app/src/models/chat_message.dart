class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? displayName;
  final String? photoUrl;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.displayName,
    this.photoUrl,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }
}
