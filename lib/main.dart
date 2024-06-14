import 'package:chat_bot_app/features/chat/data/chat_repository.dart';
import 'package:chat_bot_app/features/chat/presentation/controllers/chat_list_page_controller.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/responsive_chat.dart';
import 'package:chat_bot_app/splash_screen.dart';
import 'package:chat_bot_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

final User currentUser = User(id: 'super-band-9', role: 'user', name: 'Test user');
final User chatBotAdmin = User(id: 'chat-bot-admin', role: 'admin', name: 'Chat Bot');

enum AppChannel {
  messaging('flutterdevs', 'messaging');

  const AppChannel(this.id, this.type);

  final String id;
  final String type;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

final AppTheme appTheme = AppTheme();

class MyApp extends HookConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // initialise dependencies needed for chat
    final chatInitialiser = ref.watch(chatListPageControllerProvider);
    final client = ref.watch(chatClientProvider);

    return MaterialApp(
      // theme: appTheme.light,
      themeMode: ThemeMode.light,
      // darkTheme: appTheme.dark,
      // Wrapping the app with a builder method makes breakpoints
      // accessible throughout the widget tree.
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            if (!chatInitialiser.isLoading && chatInitialiser.value != null)
              StreamChat(
                client: client,
                streamChatThemeData: StreamChatThemeData.fromTheme(appTheme.light),
                child: StreamChannel(
                  channel: chatInitialiser.value!,
                  child: ResponsiveBreakpoints.builder(
                    breakpoints: <Breakpoint>[
                      const Breakpoint(start: 0, end: 500, name: MOBILE),
                    ],
                    child: child!,
                  ),
                ),
              ),
            IgnorePointer(
              ignoring: !chatInitialiser.isLoading,
              child:
                  const SplashScreen().animate(target: chatInitialiser.isLoading ? 0 : 1).then(delay: 1.seconds).fadeOut(duration: 300.ms),
            )
          ],
        );
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return BouncingScrollWrapper.builder(context, const ResponsiveChatList(), dragWithMouse: true);
        });
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
