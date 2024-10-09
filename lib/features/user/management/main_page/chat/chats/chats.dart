import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chats/chatting_screen.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(SchoolSizes.cardRadiusLg)),
                color: SchoolDynamicColors.activeBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 6),
                  ),
                ]
              ),
              padding: const EdgeInsets.all(SchoolSizes.md),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: SchoolSizes.spaceBtwItems,
              ),
              ChatListItem(
                  contactName: 'Aryan Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Rohit Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Arshad Shaikh',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Asad Alam',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Vedant Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Vedant Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Vedant Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Vedant Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
              ChatListItem(
                  contactName: 'Vedant Kumar',
                  lastMessage: 'hii',
                  time: '8:47 pm'),
            ],
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(image: AssetImage(
                'assets/images/banners/Its_time_to_school.jpg'),fit: BoxFit.fill),
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          contactName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 17),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          lastMessage,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: SchoolDynamicColors.activeGreen,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '1', // Replace with actual unread message count
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        },
      ),
    );
  }
}
