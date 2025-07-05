import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/chat/club_message_controller.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String clubId;

  const ChatScreen({super.key, required this.clubId});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  final GetStorage storage = GetStorage();
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  bool showAttachmentMenu = false;

  late AnimationController _attachmentAnimationController;
  late Animation<double> _attachmentAnimation;

  String userToken = '';
  int currentUserId = 0;
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    userToken = storage.read('token') ?? '';
    currentUserId = chatController.user.id!;

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );

    _attachmentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _attachmentAnimation = CurvedAnimation(
      parent: _attachmentAnimationController,
      curve: Curves.easeInOut,
    );

    scrollController.addListener(_scrollListener);
    initializeChat();
  }

  void _scrollListener() {
    if (scrollController.hasClients) {
      final showButton = scrollController.offset > 100;
      if (showButton != _showScrollToBottom) {
        setState(() {
          _showScrollToBottom = showButton;
        });
        if (showButton) {
          _fabAnimationController.forward();
        } else {
          _fabAnimationController.reverse();
        }
      }
    }
  }

  Future<void> initializeChat() async {
    try {
      await chatController.fetchClubMessages(widget.clubId, userToken);
      await chatController.initClubChat(
        clubId: widget.clubId,
        token: userToken,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to initialize chat: ${e.toString()}',
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error_outline, color: Colors.red),
      );
    }
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    final message = messageController.text.trim();
    messageController.clear();
    messageFocusNode.unfocus();
    chatController.sendClubMessage(
      int.parse(widget.clubId),
      message,
      userToken,
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      animateListToTheEnd(time: 300);
    });
  }

  void animateListToTheEnd({int time = 500}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: time),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void toggleAttachmentMenu() {
    setState(() {
      showAttachmentMenu = !showAttachmentMenu;
    });

    if (showAttachmentMenu) {
      _attachmentAnimationController.forward();
      messageFocusNode.unfocus();
    } else {
      _attachmentAnimationController.reverse();
    }
  }

  void hideAllOverlays() {
    setState(() {
      showAttachmentMenu = false;
    });
    _attachmentAnimationController.reverse();
  }

  @override
  void dispose() {
    chatController.pusher.disconnect();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    messageController.dispose();
    messageFocusNode.dispose();
    _fabAnimationController.dispose();
    _attachmentAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Club Chat',
        centerTitle: true,
        isLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.status.value == ChatStatus.loading) {
                return _buildShimmerEffect();
              }
              if (chatController.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No messages yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start the conversation!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Stack(
                children: [
                  ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: chatController.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatController.messages[index];
                      final isCurrentUser =
                          message['sender']['sender_id'].toString() ==
                          currentUserId.toString();

                      return _buildMessageBubble(message, isCurrentUser);
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: ScaleTransition(
                      scale: _fabAnimation,
                      child: FloatingActionButton.small(
                        onPressed: () {
                          hideAllOverlays();
                          FocusScope.of(context).unfocus();
                          animateListToTheEnd(time: 300);
                        },

                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          _buildMessageInput(),
          if (showAttachmentMenu)
            Positioned.fill(
              child: GestureDetector(
                onTap: hideAllOverlays,
                child: Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: _buildAttachmentMenu(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAttachmentMenu() {
    return AnimatedBuilder(
      animation: _attachmentAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _attachmentAnimation.value,
          alignment: Alignment.bottomRight,
          child: Opacity(
            opacity: _attachmentAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAttachmentButton(
                    icon: Icons.insert_drive_file,
                    label: 'Document',
                    color: Colors.indigo,
                    onTap: () {
                      // TODO: Implement document picker
                      hideAllOverlays();
                    },
                  ),
                  _buildAttachmentButton(
                    icon: Icons.photo_camera,
                    label: 'Camera',
                    color: Colors.pink,
                    onTap: () {
                      // TODO: Implement camera
                      hideAllOverlays();
                    },
                  ),
                  _buildAttachmentButton(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: Colors.purple,
                    onTap: () {
                      // TODO: Implement gallery picker
                      hideAllOverlays();
                    },
                  ),
                  _buildAttachmentButton(
                    icon: Icons.headset,
                    label: 'Audio',
                    color: Colors.orange,
                    onTap: () {
                      // TODO: Implement audio picker
                      hideAllOverlays();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: color),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(String timestamp) {
    try {
      final DateTime messageTime = DateTime.parse(timestamp);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(messageTime);

      if (difference.inDays > 0) {
        return DateFormat('MMM d, HH:mm').format(messageTime);
      } else if (difference.inHours > 0) {
        return DateFormat('HH:mm').format(messageTime);
      } else {
        return DateFormat('HH:mm').format(messageTime);
      }
    } catch (e) {
      return timestamp;
    }
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final isCurrentUser = index % 2 == 1;
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade50,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment:
                  isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
              children: [
                if (!isCurrentUser) ...[
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 12),
                ],
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                    minHeight: 60,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                if (isCurrentUser) ...[
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isCurrentUser) {
    final senderName = message['sender']['userName'] ?? 'Unknown';
    final avatarUrl = message['sender']['img'] ?? '';
    final messageTime = message['created_at'] ?? '';
    final messageText = message['message'] ?? '';

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:
                    isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  if (!isCurrentUser) ...[
                    Hero(
                      tag: 'avatar_${message['sender']['sender_id']}',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage:
                              avatarUrl.isNotEmpty
                                  ? CachedNetworkImageProvider(avatarUrl)
                                  : null,
                          child:
                              avatarUrl.isEmpty
                                  ? Text(
                                    senderName.isNotEmpty
                                        ? senderName[0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                  : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65,
                      ),
                      decoration: BoxDecoration(
                        gradient:
                            isCurrentUser
                                ? LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                : null,
                        color: isCurrentUser ? null : Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft:
                              isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(4),
                          bottomRight:
                              isCurrentUser
                                  ? const Radius.circular(4)
                                  : const Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              isCurrentUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            if (!isCurrentUser) ...[
                              Text(
                                senderName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              messageText,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.4,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _formatMessageTime(messageTime),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isCurrentUser) ...[
                    const SizedBox(width: 12),
                    Hero(
                      tag: 'avatar_current_user',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage:
                              avatarUrl.isNotEmpty
                                  ? CachedNetworkImageProvider(avatarUrl)
                                  : null,
                          child:
                              avatarUrl.isEmpty
                                  ? Icon(
                                    Icons.person,
                                    color: Colors.grey.shade600,
                                    size: 20,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            InkWell(
              onTap: toggleAttachmentMenu,
              child: Icon(Icons.attach_file, size: 30, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: messageController,
                focusNode: messageFocusNode,
                textInputAction: TextInputAction.send,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => sendMessage(),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withValues(alpha: 0.8),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                onPressed: sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
