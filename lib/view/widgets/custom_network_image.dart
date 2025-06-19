import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final double size;
  final String imageUrl;

  const CustomNetworkImage({
    super.key,
    required this.size,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Icon(Icons.error, size: size),
        errorWidget: (context, url, error) => Icon(Icons.error, size: size),
        fit: BoxFit.fill,
      ),
    );
  }
}
