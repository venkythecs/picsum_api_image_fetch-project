import 'package:flutter/material.dart';
import '../../data/models/image_model.dart';
import '../screens/full_screen_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  final bool isPaginating;

  ImageList({required this.images, required this.isPaginating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              final image = images[index];
              return ListTile(
                leading: Hero(
                  tag: image.id,
                  child: CachedNetworkImage(
                    imageUrl: image.url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                title: Text('Image ID: ${image.id}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(imageUrl: image.url),
                    ),
                  );
                },
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
