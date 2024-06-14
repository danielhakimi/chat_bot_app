import 'package:chat_bot_app/custom_message_input.dart';
import 'package:chat_bot_app/features/chat/application/chat_service.dart';
import 'package:chat_bot_app/features/chat/presentation/controllers/send_message_controller.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/response_buttons_widget.dart';
import 'package:chat_bot_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatBotMessageText {
  static const greetingsMessage = 'Hey, are you ready to start the converstation?';
  static const okByeForNowMessage = 'Ok bye for now!';
  static const companyInfoMessage =
      """That's great to hear! You'll find Alchemy very different from any dating app as we prioritize quality over quantity, offering our members a limited number of high-caliber introductions at any given time. As a professional matchmaker, I am trained to discover our members' personalities and ideal partner preferences before making highly personalized introductions.""";
  static const checkOutUserProfileMessage = 'Check out your user profile?';
}

class UserResponseMessages {
  static const yeah = 'Yeah!    😊';
  static const noTalkLater = "No, let's talk later!";
  static const checkOutUserProfileMessage = 'Check out your user profile?';
  static const qaulitySoundsGreat = 'Qaulity sounds great';
  static const noIWantVolume = 'No, I want volume';
  static const checkOutProfile = 'See profile';
}

class ChatBotMessages {
  static final greetings = ChatBotMessage(
    ChatBotMessageText.greetingsMessage,
    [ResponseOption.startConverstation, ResponseOption.noTalkLater],
    [UserResponseMessages.yeah, UserResponseMessages.noTalkLater],
  );
  static final companyInfo = ChatBotMessage(ChatBotMessageText.companyInfoMessage, [
    ResponseOption.okSoundsGreat,
    ResponseOption.noIWantVolume
  ], [
    UserResponseMessages.qaulitySoundsGreat,
    UserResponseMessages.noIWantVolume,
  ]);
  static final checkOutProfile = ChatBotMessage(ChatBotMessageText.checkOutUserProfileMessage, [
    ResponseOption.profile
  ], [
    UserResponseMessages.checkOutProfile,
  ]);

  static List get list => [greetings, companyInfo, checkOutProfile];
}

class ChatBotMessage {
  ChatBotMessage(this.message, this.responseOptions, this.userResponseOptionsText);
  final String message;
  final List<ResponseOption> responseOptions;
  final List<String> userResponseOptionsText;
}

enum ResponseOption { profile, startConverstation, noTalkLater, okSoundsGreat, noIWantVolume }

class ChatPage extends HookConsumerWidget {
  ChatPage({
    super.key,
    this.showBackButton = true,
    this.onBackPressed,
  });

  final bool showBackButton;
  final void Function(BuildContext)? onBackPressed;

  final FocusNode focusNode = FocusNode();
  final controller = ItemScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(botResponseProvider);
    useEffect(() {
      final channel = StreamChannel.of(context).channel;

      Future<void> checkAndSendFirstMessage() async {
        final List<Message> messages = channel.state?.messages ?? <Message>[];

        final mostRecentMessage = messages.mostRecentMessage;

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          Future.delayed(const Duration(milliseconds: 300), () async {
            await controller.scrollTo(index: 0, duration: 300.ms);
          });
        });

        if (mostRecentMessage?.user?.id == currentUser.id) {
          await ref.read(chatServiceProvider).sendMessageFromBot(ChatBotMessageText.greetingsMessage);
        }

        if (mostRecentMessage?.text == ChatBotMessageText.okByeForNowMessage) {
          await ref.read(chatServiceProvider).sendMessageFromBot(ChatBotMessageText.greetingsMessage);
        }
      }

      checkAndSendFirstMessage();

      return null;
    }, []);
    final ValueNotifier<StreamMessageInputController> messageInputControllerNotifier = useValueNotifier(StreamMessageInputController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamMessageListView(
            showUnreadIndicator: false,
            scrollController: controller,
            messageBuilder: (p0, p1, p2, defaultMessageWidget) {
              return defaultMessageWidget.copyWith(
                textBuilder: (p0, p1) {
                  return Column(
                    children: [Text(p1.text ?? ''), ResponseButtonsWidget(message: p1)],
                  );
                },
              );
            },
          )),
          CustomMessageInput(
            controller: messageInputControllerNotifier.value,
            onSendPressed: (String text) {
              ref.read(sendMessageControllerProvider.notifier).sendMessage(currentUser, text);
            },
          )
        ],
      ),
    );
  }
}

extension MessagesExtension on List<Message> {
  Message? get mostRecentMessage {
    if (isEmpty) {
      return null;
    }
    final DateTime currentTime = DateTime.now();

    final closestMessage = reduce((Message a, Message b) {
      final Duration aDiff = (a.createdAt.difference(currentTime)).abs();
      final Duration bDiff = (b.createdAt.difference(currentTime)).abs();
      return aDiff < bDiff ? a : b;
    });

    return closestMessage;
  }
}
