import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/chat_service.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

final chatServiceProvider = Provider((ref) => ChatService());

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier(ref.read(chatServiceProvider));
});

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final ChatService _chatService;

  ChatNotifier(this._chatService) : super([
    ChatMessage(text: 'Halo! Ada yang bisa MoPro Agent bantu terkait aplikasi ini?', isUser: false),
  ]);

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    state = [...state, ChatMessage(text: text, isUser: true)];
    
    try {
      final response = await _chatService.sendMessage(text);
      state = [...state, ChatMessage(text: response, isUser: false)];
    } catch (e) {
      state = [...state, ChatMessage(text: 'Maaf, terjadi kesalahan koneksi.', isUser: false)];
    }
  }
}
