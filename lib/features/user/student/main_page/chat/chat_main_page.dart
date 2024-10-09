import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/calls/calls.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chats/chats.dart';
import 'package:my_school_app/features/user/student/main_page/chat/groups/groups.dart';
import 'package:my_school_app/features/user/student/main_page/chat/status/status.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/theme/widget_themes/tab_bar_theme.dart';

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: SchoolDynamicColors.backgroundColorPrimaryDarkGrey,
          leading: const Icon(Icons.mark_chat_read_outlined,
              color: SchoolDynamicColors.white),
          title: const Text(
            'Chatoo',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: SchoolDynamicColors.white),
          ),
          actions: const [
            Icon(Icons.search_rounded,color: Colors.white,),
            SizedBox(width: SchoolSizes.defaultSpace),
            Icon(Icons.more_vert,color: Colors.white,),
            SizedBox(
              width: SchoolSizes.defaultSpace,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Theme(
              data: Theme.of(context).copyWith(
                tabBarTheme: SchoolTabBarTheme.defaultTabBarTheme,
              ),
              child: TabBar(
                controller: tabController,
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
                unselectedLabelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
                unselectedLabelColor: Colors.white.withOpacity(0.6),
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,
                indicatorColor: Colors.white,
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
