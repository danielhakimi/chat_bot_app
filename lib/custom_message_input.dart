import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CustomMessageInput extends StatelessWidget {

  const CustomMessageInput({super.key, required this.controller, this.onSendPressed});
  final StreamMessageInputController controller;
  final Function(String)? onSendPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller.textFieldController,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  onSendPressed?.call(controller.text);
                  controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
