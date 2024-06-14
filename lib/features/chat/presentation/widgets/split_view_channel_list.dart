import 'package:chat_bot_app/features/chat/presentation/widgets/channel_list_page.dart';
import 'package:chat_bot_app/features/chat/presentation/widgets/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SplitViewChannelList extends StatefulWidget {
  const SplitViewChannelList({super.key});

  @override
  State<SplitViewChannelList> createState() => _SplitViewChannelListState();
}

class _SplitViewChannelListState extends State<SplitViewChannelList> {
  Channel? selectedChannel;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          child: ChannelListPage(
            onTap: (Channel channel) {
              setState(() {
                selectedChannel = channel;
              });
            },
            selectedChannel: StreamChannel.of(context).channel,
          ),
        ),
        Flexible(
          flex: 2,
          child: ClipPath(
            child: Scaffold(
              body: selectedChannel != null
                  ? StreamChannel(
                      key: ValueKey<String?>(selectedChannel!.cid),
                      channel: selectedChannel!,
                      child: ChatPage(showBackButton: false),
                    )
                  : Center(
                      child: Text(
                        'Pick a channel to show the messages 💬',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
