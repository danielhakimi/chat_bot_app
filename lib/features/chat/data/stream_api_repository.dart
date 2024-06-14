import 'dart:convert';
import 'package:chat_bot_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'stream_api_repository.g.dart';

const chatBotAdminUserToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY2hhdC1ib3QtYWRtaW4ifQ.WQT6aAnfIbtTyiUVn31h9n02oSNWMKCfRU08zQXGdqY';

class StreamApiRepository {
  StreamApiRepository({
    required this.apiKey,
    required this.userToken,
    required this.channelId,
  });
  final String apiKey;
  final String userToken;
  final String channelId;

  Future<void> sendMessageFromBot(String messageText) async {
    final url = 'https://chat.stream-io-api.com/channels/${AppChannel.messaging.type}/${AppChannel.messaging.id}/message';

    final messageJson = Message(user: chatBotAdmin, text: messageText).toJson();
    final messagePayload = {'message': messageJson};
    final jsonEncode2 = jsonEncode(messagePayload);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'api_key': apiKey,
        'Authorization': chatBotAdminUserToken,
        'stream-auth-type': 'jwt',
        'Content-Type': 'application/json',
      },
      body: jsonEncode2,
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send message: ${response.body}');
    }
  }
}

@riverpod
StreamApiRepository streamApiRepository(StreamApiRepositoryRef ref) {
  return StreamApiRepository(apiKey: 'rbnjx6a64feg', userToken: chatBotAdminUserToken, channelId: AppChannel.messaging.id);
}
