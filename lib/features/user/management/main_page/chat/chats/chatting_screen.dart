import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

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
  Widget ChattingAppBar(){
    return Row(
      children: [
        InkWell(
          onTap: (){Get.back();},
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),

              Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage:
                AssetImage('assets/images/banners/Its_time_to_school.jpg'),
              )
            ],
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: false,
        backgroundColor: SchoolDynamicColors.primaryColor,
        leading: InkWell(
          onTap: (){Get.back();},
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),

              Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage:
                    AssetImage('assets/images/banners/Its_time_to_school.jpg'),
              )
            ],
          ),
        ),
        title: Text(
          'Aryan Kumar',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.videocam_rounded, size: 26, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.call_rounded,size: 24, color: Colors.white)),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
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
              padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Type a message',
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
      status: MessageStatus.Seen,
      isSentByMe: true,
      animationController: _animationController,
      time: '10:44 am',
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
  final String time;
  bool isSentByMe;
  final MessageStatus status;
  final AnimationController animationController;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isSentByMe,
    required this.status,
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
            Expanded(
              child: Column(
                crossAxisAlignment: isSentByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: Get.width * 0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isSentByMe
                          ? SchoolHelperFunctions.isDarkMode(context)
                              ? SchoolDynamicColors.activeBlue.withOpacity(1)
                              : SchoolDynamicColors.activeBlue
                          : SchoolHelperFunctions.isDarkMode(context)
                              ? SchoolDynamicColors.lightGreyBackgroundColor
                              : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isSentByMe ? 12.0 : 0),
                        topRight: Radius.circular(isSentByMe ? 0 : 12.0),
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isSentByMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: isSentByMe
                                ? Colors.white
                                : SchoolDynamicColors.headlineTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              time,
                              style: TextStyle(
                                color: isSentByMe
                                    ? Colors.white.withOpacity(0.5)
                                    : SchoolDynamicColors.subtitleTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            if (isSentByMe && status == MessageStatus.Seen)
                              Icon(
                                Icons.done_all_rounded,
                                size: 16,
                                color: Colors.white,
                              )
                            else if (isSentByMe &&
                                status == MessageStatus.Received)
                              Icon(
                                Icons.done_all_rounded,
                                size: 16,
                                color: Colors.white.withOpacity(0.5),
                              )
                            else if (isSentByMe &&
                                status == MessageStatus.NotSend)
                              Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white.withOpacity(0.5),
                              )
                          ],
                        ),
                      ],
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

enum MessageStatus { Received, Seen, NotSend }
