import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:maritimmuda_connect/themes.dart';

class ZoomableImageView extends StatelessWidget {
  final String imageUrl;

  const ZoomableImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        // Added Center widget
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialScale: PhotoViewComputedScale.contained, // Added initial scale
          basePosition: Alignment.center, // Added base position
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              color: primaryDarkBlueColor,
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
      ),
    );
  }
}
