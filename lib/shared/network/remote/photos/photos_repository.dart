import 'dart:convert';
import 'package:photo_app/.env.dart';
import 'package:photo_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:photo_app/models/photo_model.dart';
import 'package:photo_app/shared/network/remote/repositories.dart';

class PhotosRepository extends BasePhotosRepository {
  static const String _unsplashBaseUrl = 'https://api.unsplash.com';
  static const int numPerPage = 10;

  final http.Client _httpClient;

  PhotosRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  void dispose() {
    _httpClient.close();
  }

  @override
  Future<List<Photo>> searchPhotos({
    required String query,
    int page = 1,
  }) async {
    try {
      final url =
          '$_unsplashBaseUrl/search/photos?client_id=$unsplashApiKey&page=$page&per_page=$numPerPage&query=$query';
      final response = await _httpClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(
            response.body); // converts json string to map <String,dynamic>
        final List results = data['results'];
        final List<Photo> photos =
            results.map((e) => Photo.fromMap(e)).toList();
        return photos;
      }
      throw([]);
    } catch (_) {
      throw ([]);
    }
  }
}
