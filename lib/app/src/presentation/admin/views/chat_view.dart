import 'package:bot_dashboard/app/export_app.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  ModelConfig? _modelConfig;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadModelConfig();
    _loadMessages();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await UserService().getUserData(FirebaseAuth.instance.currentUser?.email ?? '');
      setState(() {
        _currentUser = user;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user data: $e');
      }
    }
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList('chat_messages') ?? [];
    setState(() {
      _messages.addAll(
        messagesJson.map((json) => ChatMessage.fromJson(jsonDecode(json))).toList(),
      );
    });
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = _messages.map((msg) => jsonEncode(msg.toJson())).toList();
    await prefs.setStringList('chat_messages', messagesJson);
  }

  Future<void> _clearMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('chat_messages');
    setState(() {
      _messages.clear();
    });
  }

  Future<void> _loadModelConfig() async {
    try {
      final config = await ModelConfigService().getModelConfig();
      setState(() {
        _modelConfig = config;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading model config: $e');
      }
      setState(() {
        _messages.add(ChatMessage(
          text: 'Error loading model configuration. Please check your settings.',
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text;
    _messageController.clear();
    _focusNode.requestFocus(); // Request focus after clearing

    setState(() {
      _isLoading = true;
      _messages.add(ChatMessage(
        text: messageText,
        isUser: true,
        timestamp: DateTime.now(),
        photoUrl: _currentUser?.photoUrl,
        displayName: _currentUser?.displayName,
      ));
    });

    try {
      final response = await GeminiService().generateContent(
        messageText,
        _modelConfig!,
      );
      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      await _saveMessages();
    } catch (e) {
      if (kDebugMode) {
        print('Error sending message: $e');
      }
      setState(() {
        _messages.add(ChatMessage(
          text: 'Error: ${e.toString()}',
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _focusNode.requestFocus(); // Ensure focus is maintained after async operation
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 8.0,
          backgroundColor: AppConfig().appBarColor,
          title: const Text('Biosónica Asistente'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _clearMessages,
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                try {
                  await LoginService().signOut();
                } catch (e) {
                  if (kDebugMode) {
                    print('Error sending message: $e');
                  }
                  setState(() {
                    _messages.add(ChatMessage(
                      text: 'Error: ${e.toString()}',
                      isUser: false,
                      timestamp: DateTime.now(),
                    ));
                  });
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                  if (kDebugMode) {
                    print('Error al cerrar sesión: $e');
                  }
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  return MessageBubble(
                    message: message.text,
                    isUser: message.isUser,
                    timestamp: message.timestamp,
                    photoUrl: message.photoUrl,
                    displayName: message.displayName,
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    _saveMessages();
    super.dispose();
  }
}
