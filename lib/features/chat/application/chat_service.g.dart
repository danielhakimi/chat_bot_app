// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatServiceHash() => r'd23ccb1dc57f41bbf2da71c39521d5283f570790';

/// See also [chatService].
@ProviderFor(chatService)
final chatServiceProvider = AutoDisposeProvider<ChatService>.internal(
  chatService,
  name: r'chatServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatServiceRef = AutoDisposeProviderRef<ChatService>;
String _$botResponseHash() => r'13f0a348bee0253312369374357b7732183618e6';

/// See also [botResponse].
@ProviderFor(botResponse)
final botResponseProvider = AutoDisposeProvider<void>.internal(
  botResponse,
  name: r'botResponseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$botResponseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BotResponseRef = AutoDisposeProviderRef<void>;
String _$respondedMessagesHash() => r'dd67dadf0ee9c0feb3ea53a3565a4227e4564253';

/// See also [RespondedMessages].
@ProviderFor(RespondedMessages)
final respondedMessagesProvider = NotifierProvider<RespondedMessages,
    List<(ResponseOption, ChatBotMessage, String)>>.internal(
  RespondedMessages.new,
  name: r'respondedMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$respondedMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RespondedMessages
    = Notifier<List<(ResponseOption, ChatBotMessage, String)>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
