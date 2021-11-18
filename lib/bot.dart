import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  _ChatBotState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "72aa1f0d717e47fd9a862e2cb25699b92e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    print('xd -- ${AlanVoice.isActive()}');
    return Scaffold();
  }
}
