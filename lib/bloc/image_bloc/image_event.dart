abstract class ImageEvent {}

class FetchImages extends ImageEvent {
  final int page;
  FetchImages(this.page);
}