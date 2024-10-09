import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool isTyping = false;

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
        actions: [
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
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.emoji_emotions),
              onPressed: () {
                // Add emoji picker or any other action
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _textController,
                  onChanged: (text) {
                    if (text.trim().isNotEmpty != isTyping) {
                      setState(() {
                        isTyping = text.trim().isNotEmpty;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            isTyping
                ? Container()
                : IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {
                // Add attachment functionality
              },
            ),
            isTyping
                ? Container()
                : IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                // Add camera functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                setState(() {
                  isTyping = false;
                });
                _handleSubmitted(_textController.text);
              },
            ),
          ],
        ),
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
                    padding: const EdgeInsets.all(8.0),
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
