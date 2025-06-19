import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/chat/chat_controllers.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_images.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/chat%20view/widgets/message_widget.dart';
import 'package:hobby_club_app/view/chat%20view/widgets/typing_message_widget.dart';
import 'package:hobby_club_app/view/discussion%20view/discussion_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatControllers chatControllers = Get.put(ChatControllers());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBG,
      appBar: customAppBar(),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: ListView.builder(
                  controller: chatControllers.scrollController,
                  reverse: false,
                  itemCount: chatControllers.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatControllers.messages[index];
                    final bool isImage =
                        chatControllers.messages[index].type == 'image';
                    return Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        horizontal: 15,
                      ),
                      child: MessageContainer(
                        isSent: message.isSent,
                        message: message.message!,
                        time: message.time,
                        userName: message.userName,
                        isImage: isImage,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // type box
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TypeMessageBox(
              chatControllers: chatControllers,
              sendMessage: () {},
              scrollController: chatControllers.scrollController,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

PreferredSizeWidget customAppBar() {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.scaffoldBG,
    // automaticallyImplyLeading: false,
    title: const CustomAppBarTitle(title: "Club Name"),
    centerTitle: true,
    actions: [
      GestureDetector(
        onTap: () {
          Get.to(() => const DiscussionScreen(), arguments: {"id": 8});
        },
        child: Column(
          children: [
            Image.asset(AppImages.forum, height: 30),
            const Text('Discussions', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
      const SizedBox(width: 12),
    ],
    // leading: const Icon(Icons.keyboard_arrow_left, size: 30),
  );
}

class CustomAppBarTitle extends StatelessWidget {
  final String title;
  const CustomAppBarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Dimensions.font24,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}
