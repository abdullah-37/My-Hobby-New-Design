import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/raw/message_model.dart';
import 'package:hobby_club_app/utils/app_images.dart';
import 'package:image_picker/image_picker.dart';

class ChatControllers extends GetxController {
  TextEditingController messageFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();

  RxString messageText = ''.obs;
  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  final RxList<ChatMessage> messages =
      <ChatMessage>[
        ChatMessage(
          isSent: true,
          message: "Hey, have you tried the new Flutter 3.22 update?",
          time: "12:05 PM",
          userName: "UserName",
          type: 'text',
        ),
        ChatMessage(
          isSent: false,
          message: "Yeah! The hot reload seems faster now.",
          time: "12:06 PM",
          userName: "Abdullah",
          type: 'text',
        ),
        ChatMessage(
          isSent: true,
          message: "Check this screenshot from DevTools 👇",
          time: "12:06 PM",
          userName: "UserName",
          type: 'text',
        ),
        ChatMessage(
          isSent: true,
          message: "DevTools Memory Graph",
          time: "12:06 PM",
          userName: "UserName",
          type: 'image',
          mediaSource: AppImages.dummyimage,
        ),
        ChatMessage(
          isSent: false,
          message:
          "Nice! Are you using GetX or Riverpod in your current project?",
          time: "12:08 PM",
          userName: "Abdullah",
          type: 'text',
        ),
        ChatMessage(
          isSent: true,
          message: "Using GetX. Super lightweight and reactive.",
          time: "12:09 PM",
          userName: "UserName",
          type: 'text',
        ),
        ChatMessage(
          isSent: false,
          message: "Me too! Obx makes the UI so clean.",
          time: "12:10 PM",
          userName: "Abdullah",
          type: 'text',
        ),
        ChatMessage(
          isSent: true,
          message: "Here's a screenshot of my GetBuilder setup.",
          time: "12:10 PM",
          userName: "UserName",
          type: 'image',
          mediaSource: AppImages.dummyimage,
        ),
        ChatMessage(
          isSent: false,
          message: "What package do you use for animations?",
          time: "12:12 PM",
          userName: "Abdullah",
          type: 'text',
        ),
        ChatMessage(
          isSent: true,
          message:
          "`flutter_animate` is my go-to. And Lottie for complex ones.",
          time: "12:13 PM",
          userName: "UserName",
          type: 'text',
        ),
        ChatMessage(
          isSent: false,
          message: "Same here. Here's my recent Lottie integration:",
          time: "12:13 PM",
          userName: "Abdullah",
          type: 'image',
          mediaSource: AppImages.dummyimage,
        ),
        ChatMessage(
          isSent: true,
          message: "Flutter really makes UI development fun!",
          time: "12:14 PM",
          userName: "UserName",
          type: 'text',
        ),
        ChatMessage(
          isSent: false,
          message:
          "Absolutely! Especially with custom painters and shaders now.",
          time: "12:15 PM",
          userName: "Abdullah",
          type: 'text',
        ),
        ChatMessage(
          isSent: true,
          message: "Let’s collaborate on something cool soon 🔥",
          time: "12:16 PM",
          userName: "UserName",
          type: 'text',
        ),
        ChatMessage(
          isSent: false,
          message: "Count me in! 💻🚀",
          time: "12:17 PM",
          userName: "Abdullah",
          type: 'text',
        ),
      ].obs;

  void sendChatMessage() {
    messages.insert(
      0,
      ChatMessage(
        isSent: true,
        message: messageFieldController.text.trim(),
        time: "2:30 PM",
        userName: "You",
        type: 'text',
      ),
    );
    messageFieldController.clear();
  }

  void sendImage() {
    messages.insert(
      0,
      ChatMessage(
        isSent: true,
        message: messageFieldController.text.trim(),
        time: "2:30 PM",
        userName: "You",
        type: 'image',
        mediaSource: AppImages.dummyimage,
      ),
    );
    messageFieldController.clear();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    messageFieldController.addListener(() {
      messageText.value = messageFieldController.text;
    });
  }

  Future<void> pickFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  @override
  void onClose() {
    messageFieldController.dispose();
    super.onClose();
  }
}