import 'package:dartz/dartz.dart';
import 'package:remember_me/data/models/media_item_model.dart';
import '../entities/media_item.dart';
import '../../core/errors/failures.dart';

abstract class MediaRepository {
  Future<Either<Failure, List<Section>>> getSections();
  Future<Either<Failure, Unit>> addMediaItem(MediaItem item);
  Future<Either<Failure, Unit>> removeMediaItem(String itemId);
  Future<Either<Failure, Unit>> updateSections(List<Section> sections);
}