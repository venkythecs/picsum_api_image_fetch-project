import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
        ),
      ),
    );
  }
}
