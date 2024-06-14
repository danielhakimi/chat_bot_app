import 'package:chat_bot_app/features/chat/presentation/widgets/channel_list_page.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/split_view_channel_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ResponsiveChatList extends StatelessWidget {
  const ResponsiveChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Stack(
        children: <Widget>[
          ChannelListPage(
            onTap: (Channel channel) {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return StreamChannel(
                      channel: channel,
                      child: ChatPage(
                        onBackPressed: (BuildContext context) {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop();
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ).animate(target: isMobile ? 1 : 0).fadeIn(),
          IgnorePointer(
            ignoring: isMobile,
            child: const SplitViewChannelList().animate(target: ResponsiveBreakpoints.of(context).isMobile ? 0 : 1).fade(),
          ),
        ],
      ),
    );
  }
}
