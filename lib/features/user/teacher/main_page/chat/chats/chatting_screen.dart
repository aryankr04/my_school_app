import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool isTyping = false;
  FocusNode _focusNode = FocusNode();
  int maxLines = 5; // Set the maximum number of lines

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Clone'),
        backgroundColor: SchoolDynamicColors.primaryColor,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.videocam_rounded)),
          IconButton(onPressed: (){}, icon: Icon(Icons.call_rounded)),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add any action you want for the app bar
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined,
                color: SchoolDynamicColors.iconColor),
            onPressed: () {
              _focusNode.requestFocus();
              // Add emoji picker or any other action
            },
            tooltip: 'Insert Emoji',
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                //expands: true,
                controller: _textController,
                onChanged: (text) {
                  if (text.trim().isNotEmpty != isTyping) {
                    setState(() {
                      isTyping = text.trim().isNotEmpty;
                    });
                  }
                },
                decoration: InputDecoration(

                  hintText: 'Type a message',
                  hintStyle: Theme.of(context).textTheme.titleLarge,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          isTyping
              ? Container()
              : IconButton(
                  icon:
                      Icon(Icons.attach_file, color: SchoolDynamicColors.iconColor),
                  onPressed: () {
                    // Add attachment functionality
                  },
                  tooltip: 'Attach File',
                ),
          isTyping
              ? Container()
              : IconButton(
                  icon: Icon(Icons.camera_alt_rounded,
                      color: SchoolDynamicColors.iconColor),
                  onPressed: () {
                    // Add camera functionality
                  },
                  tooltip: 'Take Photo',
                ),
          IconButton(
            icon: Icon(Icons.send, color: SchoolDynamicColors.primaryColor),
            onPressed: () {
              setState(() {
                isTyping = false;
              });
              _handleSubmitted(_textController.text);
            },
            tooltip: 'Send',
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isSentByMe: true,
      animationController: _animationController,
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward().then((_) {
      // You can choose to dispose the animation controller here if needed
      // message.animationController.dispose();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final AnimationController animationController;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment:
              isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!isSentByMe)
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('U'),
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: isSentByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SchoolSizes.md, vertical: SchoolSizes.sm),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isSentByMe ? 12.0 : 0),
                        topRight: Radius.circular(isSentByMe ? 0 : 12.0),
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isSentByMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
