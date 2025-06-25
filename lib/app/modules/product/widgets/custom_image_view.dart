import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:maritimmuda_connect/themes.dart';

class ZoomableImageView extends StatefulWidget {
  final String imageUrl;
  final String? mediaType;

  const ZoomableImageView({
    super.key,
    required this.imageUrl,
    this.mediaType,
  });

  bool get isLocalFile => imageUrl.startsWith('/') || imageUrl.startsWith('file://');

  @override
  State<ZoomableImageView> createState() => _ZoomableImageViewState();
}

class _ZoomableImageViewState extends State<ZoomableImageView> {
  VideoPlayerController? _videoController;
  bool get isVideo =>
      widget.mediaType == 'video' ||
      widget.imageUrl.toLowerCase().endsWith('.mp4') ||
      widget.imageUrl.toLowerCase().endsWith('.mov') ||
      widget.imageUrl.toLowerCase().endsWith('.avi');

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _videoController = widget.isLocalFile
          ? VideoPlayerController.file(File(widget.imageUrl))
          : VideoPlayerController.networkUrl(widget.imageUrl as Uri);
      _videoController!.initialize().then((_) {
        setState(() {});
        _videoController!.play();
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isVideo) {
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
          child: _videoController != null && _videoController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(_videoController!),
                      VideoProgressIndicator(_videoController!, allowScrubbing: true),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            _videoController!.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 64,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_videoController!.value.isPlaying) {
                                _videoController!.pause();
                              } else {
                                _videoController!.play();
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    ImageProvider provider;
    try {
      provider = widget.isLocalFile
          ? FileImage(File(widget.imageUrl))
          : NetworkImage(widget.imageUrl);
    } catch (e) {
      provider = const AssetImage('assets/images/image_error.png');
    }

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
        child: PhotoView(
          imageProvider: provider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              color: primaryDarkBlueColor,
              value: event == null || event.expectedTotalBytes == null
                  ? null
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
          errorBuilder: (context, error, stackTrace) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, color: Colors.white, size: 64),
              SizedBox(height: 12),
              Text(
                'Failed to load File',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
