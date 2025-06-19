import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hobby_club_app/controller/chat/chat_controllers.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_images.dart';
import 'package:hobby_club_app/utils/constants.dart';


class TypeMessageBox extends StatelessWidget {
  final ChatControllers chatControllers;
  final Function() sendMessage;
  final ScrollController scrollController;
  const TypeMessageBox({
    super.key,
    required this.scrollController,
    required this.chatControllers,
    required this.sendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        spacing: 10,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.scaffoldBG,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Image.asset(
                            AppImages.cameraIcon,
                            height: 28,
                          ),
                          title: const Text(
                            'Camera',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () async {
                            await chatControllers.pickFromCamera();
                            Navigator.pop(context);

                            // Handle Camera logic here
                          },
                        ),
                        ListTile(
                          leading: Image.asset(
                            AppImages.galleryIcon,
                            height: 28,
                          ),
                          title: const Text(
                            'Gallery',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () async {
                            await chatControllers.pickFromGallery();
                            Navigator.pop(context);
                            // Handle Gallery logic here
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Image.asset('assets/camera_icon.png', height: 28),
          ),

          Expanded(
            child: TextField(
              onTap: () {
                // scrollController.
              },
              // onTapOutside: (e) {
              //   FocusManager.instance.primaryFocus?.unfocus();
              // },
              maxLines: 5,
              minLines: 1,
              controller: chatControllers.messageFieldController,
              // expands: true,
              cursorColor: AppColors.primary,
              onChanged: (v) {
                // print(object)
              },
              decoration: InputDecoration(
                // suffixIcon: const Icon(Icons.camera_alt_outlined),
                // suffix: Image.asset('assets/camera_icon.png'),
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 4,
                  maxWidth: 2,
                ),

                isDense: true,
                hintText: "Type a Message",
                hintStyle: const TextStyle(color: AppColors.primary),
                fillColor: AppColors.primary.withValues(alpha: 0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    Constants.chatContainerRadius,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => GestureDetector(
              child: CircleAvatar(
                radius: 19,
                backgroundColor: AppColors.primary,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.5,
                        end: 1,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: chatControllers.messageText.value.trim().isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            // print('oooooooo');
                            sendMessage();
                          },
                          child: Icon(
                            Icons.send,
                            size: 20,
                            color: Colors.white,

                            key: ValueKey<bool>(
                              chatControllers.messageText.value
                                  .trim()
                                  .isNotEmpty,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 20,
                          key: ValueKey<bool>(
                            chatControllers.messageText.value.trim().isNotEmpty,
                          ),
                        ),
                  // child: Icon(
                  //   chatControllers.messageText.value.trim().isNotEmpty
                  //       ? Icons.send
                  //       : Icons.mic,
                  //   key: ValueKey<bool>(
                  //     chatControllers.messageText.value.trim().isNotEmpty,
                  //   ),
                  //   color: Colors.white,
                  //   size: 20,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
