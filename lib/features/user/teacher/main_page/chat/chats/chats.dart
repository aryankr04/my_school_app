import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chats/chatting_screen.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(icon:Icon(Icons.add),onPressed: (){},),
        body: Column(
      children: [
        SizedBox(
          height: SchoolSizes.spaceBtwItems,
        ),
        ChatListItem(
            contactName: 'Aryan Kumar', lastMessage: 'hii', time: '8:47 pm'),
        ChatListItem(
            contactName: 'Rohit Kumar', lastMessage: 'hii', time: '8:47 pm'),
        ChatListItem(
            contactName: 'Arshad Shaikh', lastMessage: 'hii', time: '8:47 pm'),
        ChatListItem(
            contactName: 'Asad Alam', lastMessage: 'hii', time: '8:47 pm'),
        ChatListItem(
            contactName: 'Vedant Kumar', lastMessage: 'hii', time: '8:47 pm'),
      ],
    ));
  }
}

class ChatListItem extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final String time;

  ChatListItem({
    required this.contactName,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30.0,

      ),
      title: Text(
        contactName,
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5.0),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Text(
              '3', // Replace with actual unread message count
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      },
    );
  }
}
