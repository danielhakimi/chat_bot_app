import 'package:chat_bot_app/features/chat/application/chat_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'chat_list_page_controller.g.dart';

@riverpod
Future<Channel?> chatListPageController(ChatListPageControllerRef ref) async {
  return ref.read(chatServiceProvider).initialiseChatRoom();
}
