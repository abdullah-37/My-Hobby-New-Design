import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/chat/club_message_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class DemoChatScreen extends StatefulWidget {
  final String clubId;

  const DemoChatScreen({super.key, required this.clubId});

  @override
  State<DemoChatScreen> createState() => DemoChatScreenState();
}

class DemoChatScreenState extends State<DemoChatScreen> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  final GetStorage storage = GetStorage();
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();

  String userToken = '';
  int currentUserId = 0;
  bool isRecording = false;
  bool showEmojiPicker = false;
  bool showAttachmentMenu = false;

  late AnimationController _attachmentAnimationController;
  late AnimationController _recordingAnimationController;
  late Animation<double> _attachmentAnimation;
  late Animation<double> _recordingAnimation;

  @override
  void initState() {
    super.initState();
    userToken = storage.read('token') ?? '';
    currentUserId = chatController.user.id!;

    _attachmentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _recordingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _attachmentAnimation = CurvedAnimation(
      parent: _attachmentAnimationController,
      curve: Curves.easeInOut,
    );

    _recordingAnimation = CurvedAnimation(
      parent: _recordingAnimationController,
      curve: Curves.easeInOut,
    );

    initializeChat();
  }

  Future<void> initializeChat() async {
    try {
      await chatController.fetchClubMessages(widget.clubId, userToken);
      await chatController.initClubChat(
        clubId: widget.clubId,
        token: userToken,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize chat: ${e.toString()}');
    }
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final message = messageController.text.trim();
    messageController.clear();

    chatController.sendClubMessage(
      int.parse(widget.clubId),
      message,
      userToken,
    );

    hideAllOverlays();
  }

  void hideAllOverlays() {
    setState(() {
      showEmojiPicker = false;
      showAttachmentMenu = false;
    });
    _attachmentAnimationController.reverse();
  }

  void toggleAttachmentMenu() {
    setState(() {
      showAttachmentMenu = !showAttachmentMenu;
      showEmojiPicker = false;
    });

    if (showAttachmentMenu) {
      _attachmentAnimationController.forward();
      messageFocusNode.unfocus();
    } else {
      _attachmentAnimationController.reverse();
    }
  }

  void toggleEmojiPicker() {
    setState(() {
      showEmojiPicker = !showEmojiPicker;
      showAttachmentMenu = false;
    });

    if (showEmojiPicker) {
      messageFocusNode.unfocus();
    } else {
      messageFocusNode.requestFocus();
    }
    _attachmentAnimationController.reverse();
  }

  void startRecording() {
    setState(() {
      isRecording = true;
    });
    // TODO: Implement voice recording functionality
  }

  void stopRecording() {
    setState(() {
      isRecording = false;
    });
    // TODO: Implement stop recording and send voice message
  }

  void animateListToTheEnd({int time = 500}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: time),
          curve: Curves.easeInOut,
        );
      }
    });
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
              margin: const EdgeInsets.only(bottom: 80, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  const SizedBox(height: 12),
                  _buildAttachmentButton(
                    icon: Icons.photo_camera,
                    label: 'Camera',
                    color: Colors.pink,
                    onTap: () {
                      // TODO: Implement camera
                      hideAllOverlays();
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAttachmentButton(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: Colors.purple,
                    onTap: () {
                      // TODO: Implement gallery picker
                      hideAllOverlays();
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAttachmentButton(
                    icon: Icons.headset,
                    label: 'Audio',
                    color: Colors.orange,
                    onTap: () {
                      // TODO: Implement audio picker
                      hideAllOverlays();
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAttachmentButton(
                    icon: Icons.location_on,
                    label: 'Location',
                    color: Colors.green,
                    onTap: () {
                      // TODO: Implement location sharing
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isCurrentUser) {
    final senderName = message['sender']['userName'] ?? 'Unknown';
    final avatarUrl = message['sender']['img'] ?? '';
    final messageTime = message['created_at'] ?? '';
    final messageText = message['message'] ?? '';
    final messageType = message['type'] ?? 'text'; // text, image, audio, document, location

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              backgroundImage: avatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? Icon(Icons.person, size: 18, color: Colors.grey[600])
                  : null,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              margin: EdgeInsets.only(
                left: isCurrentUser ? 32 : 0,
                right: isCurrentUser ? 0 : 32,
              ),
              child: Column(
                crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? const Color(0xFF075E54) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                        bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isCurrentUser)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              senderName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xFF075E54),
                              ),
                            ),
                          ),
                        _buildMessageContent(messageType, messageText, isCurrentUser),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatTime(messageTime),
                              style: TextStyle(
                                fontSize: 11,
                                color: isCurrentUser ? Colors.white70 : Colors.grey[600],
                              ),
                            ),
                            if (isCurrentUser) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.done_all,
                                size: 16,
                                color: Colors.blue[300],
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              backgroundImage: avatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? Icon(Icons.person, size: 18, color: Colors.grey[600])
                  : null,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageContent(String type, String content, bool isCurrentUser) {
    switch (type) {
      case 'image':
        return _buildImageMessage(content);
      case 'audio':
        return _buildAudioMessage(content, isCurrentUser);
      case 'document':
        return _buildDocumentMessage(content, isCurrentUser);
      case 'location':
        return _buildLocationMessage(content, isCurrentUser);
      default:
        return Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: isCurrentUser ? Colors.white : Colors.black87,
          ),
        );
    }
  }

  Widget _buildImageMessage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 200,
        height: 150,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 200,
          height: 150,
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          width: 200,
          height: 150,
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildAudioMessage(String audioUrl, bool isCurrentUser) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: isCurrentUser ? Colors.white : const Color(0xFF075E54),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: isCurrentUser ? Colors.white30 : Colors.grey[300],
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCurrentUser ? Colors.white : const Color(0xFF075E54),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '0:15',
                  style: TextStyle(
                    fontSize: 12,
                    color: isCurrentUser ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentMessage(String documentUrl, bool isCurrentUser) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.white.withValues(alpha: 0.2) : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.insert_drive_file,
              color: isCurrentUser ? Colors.white : const Color(0xFF075E54),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Document.pdf',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isCurrentUser ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  '245 KB',
                  style: TextStyle(
                    fontSize: 12,
                    color: isCurrentUser ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMessage(String location, bool isCurrentUser) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.map,
              size: 40,
              color: Colors.grey,
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              location,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isCurrentUser ? Colors.white : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String timestamp) {
    // TODO: Implement proper time formatting
    return '12:30';
  }

  Widget _buildInputArea() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          // Emoji button
          GestureDetector(
            onTap: toggleEmojiPicker,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: showEmojiPicker ? const Color(0xFF075E54) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions_outlined,
                color: showEmojiPicker ? Colors.white : Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Text input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      focusNode: messageFocusNode,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onTap: hideAllOverlays,
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                  // Attachment button
                  GestureDetector(
                    onTap: toggleAttachmentMenu,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: showAttachmentMenu ? const Color(0xFF075E54) : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.rotate(
                        angle: showAttachmentMenu ? 0.785398 : 0, // 45 degrees in radians
                        child: Icon(
                          Icons.attach_file,
                          color: showAttachmentMenu ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send/Record button
          GestureDetector(
            onTap: messageController.text.trim().isNotEmpty ? sendMessage : null,
            onLongPressStart: messageController.text.trim().isEmpty ? (_) => startRecording() : null,
            onLongPressEnd: messageController.text.trim().isEmpty ? (_) => stopRecording() : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF075E54),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF075E54).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AnimatedBuilder(
                animation: _recordingAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isRecording ? 1.0 + (_recordingAnimation.value * 0.1) : 1.0,
                    child: Icon(
                      messageController.text.trim().isNotEmpty
                          ? Icons.send
                          : isRecording
                          ? Icons.stop
                          : Icons.mic,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    chatController.pusher.disconnect();
    scrollController.dispose();
    messageController.dispose();
    messageFocusNode.dispose();
    _attachmentAnimationController.dispose();
    _recordingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: const Icon(Icons.group, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Club Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              // TODO: Implement video call
            },
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // TODO: Implement voice call
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              // TODO: Handle menu selections
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'info', child: Text('Group info')),
              const PopupMenuItem(value: 'media', child: Text('Group media')),
              const PopupMenuItem(value: 'search', child: Text('Search')),
              const PopupMenuItem(value: 'mute', child: Text('Mute notifications')),
              const PopupMenuItem(value: 'wallpaper', child: Text('Wallpaper')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages area
          Expanded(
            child: Stack(
              children: [
                // Background pattern (optional)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.05,
                    child: Image.asset(
                      'assets/images/chat_bg.png', // Add this asset for WhatsApp-like background
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.none,
                    ),
                  ),
                ),

                // Messages list
                Obx(() {
                  if (chatController.status.value == ChatStatus.loading) {
                    return ListView.builder(
                      itemCount: 8,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: index % 2 == 0
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (chatController.messages.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No messages yet',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Say hello to get started!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    animateListToTheEnd();
                  });

                  return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: chatController.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatController.messages[index];
                      final isCurrentUser = message['sender']['sender_id'].toString() ==
                          currentUserId.toString();

                      return _buildMessageBubble(message, isCurrentUser);
                    },
                  );
                }),

                // Attachment menu overlay
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
          ),

          // Input area
          _buildInputArea(),

          // Emoji picker placeholder
          if (showEmojiPicker)
            Container(
              height: 250,
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Emoji Picker\n(To be implemented)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}