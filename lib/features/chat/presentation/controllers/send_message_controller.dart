import 'package:chat_bot_app/features/chat/application/chat_service.dart';
import 'package:chat_bot_app/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'send_message_controller.g.dart';

@riverpod
class SendMessageController extends _$SendMessageController {
  @override
  FutureOr<void> build() {}

  FutureOr<void> sendMessage(User user, String text) {
    if (user == chatBotAdmin) {
      ref.read(chatServiceProvider).sendMessageFromBot(text);
    } else {
      ref.read(chatServiceProvider).sendMessageFromCurrentUser(text);
    }
  }
}
