import 'dart:collection';

import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:chat_bot_app/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'chat_repository.g.dart';

abstract class IChatRepository {
  Future<void> connectUser(User user, String token);
  Future<void> deleteChannelIfExists(AppChannel appChannel);
  Future<Channel?> createAndWatchChannel({required AppChannel appChannel, required List<String> userIds});
  Future<SendMessageResponse> sendMessageToBot(String text);
}

// TODO: replace StreamChatClient with IChatClient interface
abstract class IChatClient {
  Future<OwnUser> connectUser(User user, String token, {bool connectWebSocket = true});
  Future<OwnUser> queryChannels(User user, String token, {bool connectWebSocket = true});
}

class ChatRepository implements IChatRepository {
  ChatRepository({required StreamChatClient client}) : _client = client;
  final StreamChatClient _client;
  final Set<(ResponseOption, ChatBotMessage)> respondedMessages = HashSet();

  @override
  Future<void> connectUser(User user, String token) async {
    await _client.connectUser(user, token);
  }

  @override
  Future<void> deleteChannelIfExists(AppChannel appChannel) async {
    try {
      final Stream<List<Channel>> channels = _client.queryChannels(filter: Filter.equal('id', appChannel.id));
      final List<Channel>? exists = await channels.firstOrNull;

      if (exists != null && exists.isNotEmpty == true) {
        await _client.deleteChannel(appChannel.id, appChannel.type);
      }
    } catch (_) {}
  }

  @override
  Future<Channel?> createAndWatchChannel({required AppChannel appChannel, required List<String> userIds}) async {
    try {
      final channel = _client.mainChannel;
      await channel.create();
      await channel.watch();
      await channel.addMembers(userIds);
      return channel;
    } catch (_) {
      Logger('ChatRepository').log(Level.SEVERE, 'channel not created, try again!');
      return null;
    }
  }

  Channel get mainChannel => _client.mainChannel;

  @override
  Future<SendMessageResponse> sendMessageToBot(String text) {
    return _client.mainChannel.sendMessage(Message(text: text));
  }
}

@Riverpod(keepAlive: true)
StreamChatClient chatClient(ChatClientRef ref) {
  final StreamChatClient client = StreamChatClient(
    'rbnjx6a64feg',
    logLevel: Level.INFO,
  );

  return client;
}

@riverpod
ChatRepository chatRepo(ChatRepoRef ref) {
  final client = ref.watch(chatClientProvider);
  final repo = ChatRepository(client: client);
  return repo;
}

extension StreamChatClientExtension on StreamChatClient {
  Channel get mainChannel => channel(AppChannel.messaging.type, id: AppChannel.messaging.id);
}
