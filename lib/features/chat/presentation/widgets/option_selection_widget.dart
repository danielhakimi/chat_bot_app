import 'package:chat_bot_app/features/chat/application/chat_service.dart';
import 'package:chat_bot_app/features/chat/presentation/controllers/send_message_controller.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:chat_bot_app/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OptionSelectionWidget extends ConsumerWidget {
  const OptionSelectionWidget({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.provider,
    required this.chatBotMessage,
    required this.userResponseText,
    required this.messageId,
  });

  final ResponseOption option;
  final (ResponseOption?, String?) selectedOption;
  final RespondedMessages provider;
  final ChatBotMessage chatBotMessage;
  final String userResponseText;
  final String messageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOptionMessageId = selectedOption.$2;
    final responseOption = selectedOption.$1;
    final hasOptionBeenSelected = responseOption == option && selectedOptionMessageId == messageId;
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            userResponseText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: hasOptionBeenSelected == true ? Colors.grey : null),
          ),
        ],
      ),
      onTap: () {
        if (selectedOptionMessageId == messageId) {
          return;
        }
        ref.read(sendMessageControllerProvider.notifier).sendMessage(currentUser, userResponseText);
        provider.markAsResponded((option, chatBotMessage, messageId));
      },
    );
  }
}
