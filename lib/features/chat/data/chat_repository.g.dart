// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatClientHash() => r'63483612603b4da578a99dc5fa91c632d4e9c78e';

/// See also [chatClient].
@ProviderFor(chatClient)
final chatClientProvider = Provider<StreamChatClient>.internal(
  chatClient,
  name: r'chatClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatClientRef = ProviderRef<StreamChatClient>;
String _$chatRepoHash() => r'a964bda074089c44f95c73c78b3a0769da517824';

/// See also [chatRepo].
@ProviderFor(chatRepo)
final chatRepoProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepo,
  name: r'chatRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatRepoRef = AutoDisposeProviderRef<ChatRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
