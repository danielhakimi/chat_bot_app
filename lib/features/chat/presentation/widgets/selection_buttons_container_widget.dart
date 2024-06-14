import 'package:chat_bot_app/features/chat/application/chat_service.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/option_selection_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectionButtonsContainerWidget extends ConsumerWidget {
  const SelectionButtonsContainerWidget({super.key, required this.chatBotMessage, required this.messageId});
  final ChatBotMessage chatBotMessage;
  final String messageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(respondedMessagesProvider.notifier);

    final selectedOption = provider.selectedOptionForMessage(chatBotMessage, messageId);

    return Column(
      children: [
        const Divider(thickness: 0.4),
        const SizedBox(height: 4),
        ...chatBotMessage.userResponseOptionsText.mapIndexed(
          (index, e) => Column(
            children: [
              OptionSelectionWidget(
                option: chatBotMessage.responseOptions[index],
                selectedOption: selectedOption,
                provider: provider,
                chatBotMessage: chatBotMessage,
                userResponseText: e,
                messageId: messageId,
              ),
              if (index != chatBotMessage.userResponseOptionsText.length - 1) const Divider(thickness: 0.4),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
