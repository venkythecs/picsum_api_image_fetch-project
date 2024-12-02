import 'package:dio/dio.dart';
import '../models/image_model.dart';

class ImageRepository {
  final Dio _dio = Dio();

  Future<List<ImageModel>> fetchImages(int page, int limit) async {
  final response = await _dio.get(
      'https://picsum.photos/v2/list?page=$page&limit=$limit');
  return (response.data as List<dynamic>) // Explicitly cast as List<dynamic>
      .map((json) => ImageModel.fromJson(json as Map<String, dynamic>))
      .toList();
 }
}