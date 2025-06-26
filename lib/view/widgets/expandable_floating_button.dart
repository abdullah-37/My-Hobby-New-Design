import 'package:flutter/material.dart';

class ExpandableFabMenu extends StatefulWidget {
  final Function onMessengerTap;
  final Function onCreateFeedTap;
  final Function onDiscussionTap;

  const ExpandableFabMenu({
    super.key,
    required this.onCreateFeedTap,
    required this.onMessengerTap,
    required this.onDiscussionTap,
  });

  @override
  State<ExpandableFabMenu> createState() => _ExpandableFabMenuState();
}

class _ExpandableFabMenuState extends State<ExpandableFabMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildGradientButton({
    required String label,
    required IconData icon,
    required String heroTag,
    required VoidCallback onTap,
    List<Color>? gradientColors,
  }) {
    return FloatingActionButton.extended(
      heroTag: heroTag,
      onPressed: _isMenuOpen ? () {
        onTap();
        _toggleMenu();
      } : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ?? [Colors.pink, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _animationController,
              child: Column(
                children: [
                  _buildGradientButton(
                    label: 'Create Feed',
                    icon: Icons.create,
                    heroTag: 'feed',
                    onTap: () {
                      widget.onCreateFeedTap();
                      _toggleMenu();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Create Feed tapped')),
                      // );
                    },
                    gradientColors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  _buildGradientButton(
                    label: 'Messenger',
                    icon: Icons.chat,
                    heroTag: 'chat',
                    onTap: () {
                      _toggleMenu();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Chat tapped')),
                      // );
                      widget.onMessengerTap();
                    },
                    gradientColors: [Colors.blue, Colors.indigo],
                  ),
                  _buildGradientButton(
                    label: 'Discussions',
                    icon: Icons.discord_outlined,
                    heroTag: 'discussions',
                    onTap: () {
                      _toggleMenu();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Chat tapped')),
                      // );
                      widget.onDiscussionTap();
                    },
                    gradientColors: [
                      Theme.of(context).colorScheme.secondary,
                      Colors.indigo,
                    ],
                  ),
                ],
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            heroTag: 'main',
            onPressed: _toggleMenu,
            child: Icon(
              _isMenuOpen ? Icons.close : Icons.menu_open,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
