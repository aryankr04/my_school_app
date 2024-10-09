import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/calls/calls.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chats/chats.dart';
import 'package:my_school_app/features/user/student/main_page/chat/groups/groups.dart';
import 'package:my_school_app/features/user/student/main_page/chat/status/status.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({Key? key}) : super(key: key);

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final Color indicatorColor =
        brightness == Brightness.light ? Colors.white : SchoolDynamicColors.white;
    final Color selectedLabelColor =
        brightness == Brightness.light ? Colors.white : SchoolDynamicColors.white;
    final Color tabBarColor = brightness == Brightness.light
        ? SchoolDynamicColors.primaryColor
        : SchoolDynamicColors.primaryColor.withOpacity(0.01);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.mark_chat_read_outlined),
          title: const Text(
            'Chatoo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: const [
            Icon(Icons.search_rounded),
            SizedBox(width: SchoolSizes.defaultSpace),
            Icon(Icons.more_vert),
            SizedBox(
              width: SchoolSizes.defaultSpace,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: tabBarColor,
              child: TabBar(
                controller: tabController,
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
                labelColor: selectedLabelColor,
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                indicatorColor: indicatorColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Chats'),
                  Tab(text: 'Groups'),
                  Tab(text: 'Status'),
                  Tab(text: 'Calls'),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  // Chats Screen
                  Chats(),

                  // Groups Screen
                  Groups(),

                  // Status Screen
                  Status(),

                  // Calls Screen
                  Calls()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
