import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    super.key,
    this.onTap,
    this.selectedChannel,
  });

  final void Function(Channel)? onTap;
  final Channel? selectedChannel;

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late final StreamChannelListController _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      <Object>[StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const <SortOption<ChannelState>>[SortOption<ChannelState>('last_message_at')],
    limit: 20,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamChannelListView(
          onChannelTap: widget.onTap,
          controller: _listController,
          itemBuilder: (BuildContext context, List<Channel> channels, int index, StreamChannelListTile defaultWidget) {
            return defaultWidget.copyWith(
              selected: channels[index] == widget.selectedChannel,
            );
          },
        ),
      );
}
