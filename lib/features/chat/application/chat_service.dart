import 'package:chat_bot_app/features/chat/data/chat_repository.dart';
import 'package:chat_bot_app/features/chat/data/stream_api_repository.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:chat_bot_app/main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'chat_service.g.dart';

class ChatService {
  ChatService(this._chatRepository, this._streamApiRepository);
  final IChatRepository _chatRepository;
  final StreamApiRepository _streamApiRepository;

  Future<Channel?> initialiseChatRoom() async {
    final repo = _chatRepository;

    final channel = repo
        .connectUser(
          currentUser,
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic3VwZXItYmFuZC05In0.rqf4CZ3yQdtJJXIVrnqCh44t_jEWXBkS7OJxYrJAKD0',
        )
        .then((value) => repo.deleteChannelIfExists(AppChannel.messaging))
        .then((value) =>
            Future.delayed(const Duration(seconds: 1))) // slight delay to wait for the channel to fully delete from the last step
        .then((value) => repo.createAndWatchChannel(appChannel: AppChannel.messaging, userIds: [chatBotAdmin.id, currentUser.id]))
        .catchError((err) {
      debugPrint('There was an issue with creating the stream client and/or creating the channel');
      debugPrint(err.toString());

      return null;
    });

    return channel;
  }

  // Future<void> resetChatRoom() async {
  //   await _chatRepository.deleteChannelIfExists(AppChannel.messaging).then((value) => Future.delayed(1.seconds)).then(
  //         (value) => _chatRepository.createAndWatchChannel(appChannel: AppChannel.messaging, userIds: [chatBotAdmin.id, currentUser.id]),
  //       );
  // }

  Future<void> sendMessageFromCurrentUser(String text) async {
    await _chatRepository.sendMessageToBot(text);
  }

  Future<void> sendMessageFromBot(String text) async {
    try {
      await _streamApiRepository.sendMessageFromBot(text);
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}

@riverpod
ChatService chatService(ChatServiceRef ref) {
  final chatRepo = ref.watch(chatRepoProvider);
  final streamApiProvider = ref.watch(streamApiRepositoryProvider);

  return ChatService(chatRepo, streamApiProvider);
}

@riverpod
void botResponse(BotResponseRef ref) {
  final messages = ref.watch(respondedMessagesProvider);
  final chatRepo = ref.watch(chatRepoProvider);
  final channelMessage = chatRepo.mainChannel.state?.messages ?? [];

  if (channelMessage.isEmpty) {
    // final msg = Random().nextBool() ? ChatBotMessageText.greetingsMessage : ChatBotMessageText.checkOutUserProfileMessage;
    ref.read(chatServiceProvider).sendMessageFromBot(ChatBotMessageText.greetingsMessage);

    return;
  }

  if (channelMessage.mostRecentMessage?.user?.id == chatBotAdmin.id) {
    return;
  }

  final last = messages.last;
  final botResponseMessage = switch (last.$1) {
    ResponseOption.startConverstation => ChatBotMessageText.companyInfoMessage,
    ResponseOption.noTalkLater => ChatBotMessageText.okByeForNowMessage,
    _ => ''
  };

  if (botResponseMessage.isNotEmpty) {
    ref.read(chatServiceProvider).sendMessageFromBot(botResponseMessage);
  }
}

@Riverpod(keepAlive: true)
class RespondedMessages extends _$RespondedMessages {
  @override
  List<(ResponseOption, ChatBotMessage, String)> build() {
    return [];
  }

  bool hasRespondedTo(ChatBotMessage msg) {
    return state.any((element) => element.$2.message == msg.message);
  }

  void markAsResponded((ResponseOption, ChatBotMessage, String) msg) {
    state = [...state, msg];
  }

  (ResponseOption?, String? msgId) selectedOptionForMessage(ChatBotMessage msg, String messageId) {
    final item = state.firstWhereOrNull((element) => element.$2.message == msg.message && element.$3 == messageId);
    return (item?.$1, item?.$3);
  }
}
