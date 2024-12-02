import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/image_model.dart';
import '../../data/repositories/image_repository.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository repository;
  int currentPage = 1;
  bool hasMore = true;

  ImageBloc(this.repository) : super(ImageInitial()) {
    on<FetchImages>((event, emit) async {
    if (!hasMore) return;

    if (state is ImageLoaded) {
      emit(ImagePaginationLoading((state as ImageLoaded).images, hasMore));
    } else {
      emit(ImageLoading());
    }

    try {
      final images = await repository.fetchImages(event.page, 10);
      hasMore = images.isNotEmpty;
      currentPage = event.page;

      emit(ImageLoaded(
        (state is ImageLoaded ? (state as ImageLoaded).images : <ImageModel>[]) + images,
        hasMore,
      ));
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  });

    
  }
}
