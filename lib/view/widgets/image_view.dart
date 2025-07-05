import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        isLeading: true,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: CachedNetworkImageProvider(widget.image),
            loadingBuilder: (context, event) {
              if (event == null) {
                return Center(child: Text(
                  'Loading...',
                  style: theme.textTheme.bodyMedium,
                ));
              }
              return Center(
                child: CircularProgressIndicator(
                  value: event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                  color: theme.colorScheme.primary,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: theme.colorScheme.error,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load image',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundDecoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}