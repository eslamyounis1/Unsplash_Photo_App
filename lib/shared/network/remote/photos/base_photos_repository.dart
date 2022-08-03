import 'package:photo_app/shared/network/remote/repositories.dart';
import 'package:photo_app/models/models.dart';
abstract class BasePhotosRepository extends BaseRepository{

  Future<List<Photo>> searchPhotos({required String query,int page});
}