import '../../data/models/image_model.dart';

abstract class ImageState {
  final List<ImageModel> images = <ImageModel>[];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<ImageModel> images;
  final bool hasMore;
  ImageLoaded(this.images, this.hasMore);
}

class ImageError extends ImageState {
  final String message;
  ImageError(this.message);
}

class ImagePaginationLoading extends ImageLoaded {
  ImagePaginationLoading(List<ImageModel> images, bool hasMore)
      : super(images, hasMore);
}
