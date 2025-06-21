import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/theme_controller.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';

class CreatePostDialog extends StatefulWidget {
  final Function(String description, String? imagePath)? onPostCreated;

  const CreatePostDialog({super.key, this.onPostCreated});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<Offset> _slideAnimation;

  String? _selectedImagePath;
  bool _isPosting = false;
  int _characterCount = 0;
  final int _maxCharacters = 280;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _textController.addListener(() {
      setState(() {
        _characterCount = _textController.text.length;
      });
    });

    _animationController.forward();

    // Auto focus on text field after animation
    Future.delayed(const Duration(milliseconds: 400), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _buttonAnimationController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _selectImage() async {
    // Simulate image picker - replace with actual image picker implementation
    HapticFeedback.lightImpact();

    // Show image picker options
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildImagePickerBottomSheet(),
    );
  }

  Widget _buildImagePickerBottomSheet() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Add Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageOption(
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () {
                  Navigator.pop(context);
                  // Simulate camera capture
                  setState(() {
                    _selectedImagePath =
                        "https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}";
                  });
                },
              ),
              _buildImageOption(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () {
                  Navigator.pop(context);
                  // Simulate gallery selection
                  setState(() {
                    _selectedImagePath =
                        "https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}";
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeImage() {
    setState(() {
      _selectedImagePath = null;
    });
    HapticFeedback.lightImpact();
  }

  void _createPost() async {
    if (_textController.text.trim().isEmpty) {
      _showErrorSnackBar('Please write something to post');
      return;
    }

    setState(() {
      _isPosting = true;
    });

    HapticFeedback.mediumImpact();
    _buttonAnimationController.forward().then((_) {
      _buttonAnimationController.reverse();
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (widget.onPostCreated != null) {
      widget.onPostCreated!(_textController.text.trim(), _selectedImagePath);
    }

    setState(() {
      _isPosting = false;
    });

    Navigator.of(context).pop();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Post created successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                decoration: BoxDecoration(
                  color:
                      themeController.themeMode.value == ThemeMode.dark
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          // colors: [Colors.deepPurple, Colors.purple],
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.create,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Create New Post',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Section
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.deepPurple.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 22,
                                    backgroundImage: NetworkImage(
                                      "https://picsum.photos/150/150?random=currentuser",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'John Doe',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      '@john_doe',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Text Input
                            TextFormField(
                              controller: _textController,
                              focusNode: _focusNode,
                              maxLines: 6,
                              // maxLength: _maxCharacters,
                              decoration: InputDecoration(
                                hintText: 'Whats on your mind',
                              ),
                            ),

                            // Character Counter
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 8),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       const SizedBox(),
                            //       Text(
                            //         '$_characterCount/$_maxCharacters',
                            //         style: TextStyle(
                            //           color:
                            //               _characterCount > _maxCharacters * 0.8
                            //                   ? Colors.red
                            //                   : Colors.grey,
                            //           fontSize: 12,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(height: 20),

                            // Selected Image
                            if (_selectedImagePath != null) ...[
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(_selectedImagePath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: _removeImage,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.7,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // Action Buttons
                            Container(
                              // padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    themeController.themeMode.value ==
                                            ThemeMode.dark
                                        ? Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                // border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildActionIcon(
                                    icon: Icons.photo_camera,
                                    label: 'Photo',
                                    onTap: _selectImage,
                                  ),
                                  const SizedBox(width: 20),
                                  _buildActionIcon(
                                    icon: Icons.video_camera_back_outlined,
                                    label: 'Video',
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      // _showErrorSnackBar(
                                      //   'GIF feature coming soon!',
                                      // );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Actions
                    // Container(
                    //   padding: const EdgeInsets.all(20),
                    //   decoration: BoxDecoration(
                    //     color:
                    //         themeController.themeMode.value == ThemeMode.dark
                    //             ? Theme.of(context).scaffoldBackgroundColor
                    //             : Colors.white,
                    //     borderRadius: const BorderRadius.vertical(
                    //       bottom: Radius.circular(20),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       // Privacy Selector
                    //       // Container(
                    //       //   padding: const EdgeInsets.symmetric(
                    //       //     horizontal: 12,
                    //       //     vertical: 8,
                    //       //   ),
                    //       //   decoration: BoxDecoration(
                    //       //     color: Colors.white,
                    //       //     borderRadius: BorderRadius.circular(20),
                    //       //     border: Border.all(color: Colors.grey[300]!),
                    //       //   ),
                    //       //   child: const Row(
                    //       //     mainAxisSize: MainAxisSize.min,
                    //       //     children: [
                    //       //       Icon(
                    //       //         Icons.public,
                    //       //         size: 16,
                    //       //         color: Colors.deepPurple,
                    //       //       ),
                    //       //       SizedBox(width: 4),
                    //       //       Text(
                    //       //         'Public',
                    //       //         style: TextStyle(
                    //       //           fontSize: 12,
                    //       //           color: Colors.deepPurple,
                    //       //           fontWeight: FontWeight.w500,
                    //       //         ),
                    //       //       ),
                    //       //       Icon(
                    //       //         Icons.arrow_drop_down,
                    //       //         size: 16,
                    //       //         color: Colors.deepPurple,
                    //       //       ),
                    //       //     ],
                    //       //   ),
                    //       // ),

                    //       // const Spacer(),

                    // Post Button
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomElevatedButton(onTap: () {}, title: 'Post'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example:
// To show the dialog, use this in your onPressed for the plus icon:
/*
void _showCreatePostDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CreatePostDialog(
      onPostCreated: (description, imagePath) {
        // Handle the created post
        print('Post created: $description');
        if (imagePath != null) {
          print('Image: $imagePath');
        }
        // Add the post to your feed data
        // Refresh your feed UI
      },
    ),
  );
}
*/
