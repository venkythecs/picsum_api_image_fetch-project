import 'package:flutter/material.dart';
import '../../data/models/image_model.dart';
import '../screens/full_screen_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageGrid extends StatelessWidget {
  final List<ImageModel> images;
  final bool isPaginating;

  ImageGrid({required this.images, required this.isPaginating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final image = images[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(imageUrl: image.url),
                    ),
                  );
                },
                child: Hero(
                  tag: image.id,
                  child: CachedNetworkImage(
                    imageUrl: image.url,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              );
            },
          ),
        ),
        if (isPaginating)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
