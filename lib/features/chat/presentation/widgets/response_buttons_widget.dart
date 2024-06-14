import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/selection_buttons_container_widget.dart';
import 'package:chat_bot_app/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ResponseButtonsWidget extends ConsumerWidget {
  const ResponseButtonsWidget({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (message.user?.id == currentUser.id) {
      return const SizedBox.shrink();
    }

    return switch (message.text) {
      ChatBotMessageText.greetingsMessage => SelectionButtonsContainerWidget(
          chatBotMessage: ChatBotMessages.greetings,
          messageId: message.id,
        ),
      ChatBotMessageText.companyInfoMessage => SelectionButtonsContainerWidget(
          chatBotMessage: ChatBotMessages.companyInfo,
          messageId: message.id,
        ),
      ChatBotMessageText.checkOutUserProfileMessage => SelectionButtonsContainerWidget(
          chatBotMessage: ChatBotMessages.checkOutProfile,
          messageId: message.id,
        ),
      _ => const SizedBox.shrink()
    };
  }
}
