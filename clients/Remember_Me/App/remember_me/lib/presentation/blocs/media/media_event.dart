import 'package:equatable/equatable.dart';
import 'package:remember_me/data/models/media_item_model.dart';
import 'package:remember_me/domain/entities/media_item.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object?> get props => [];
}

class MediaLoadRequested extends MediaEvent {}

class MediaItemAdded extends MediaEvent {
  final MediaItem item;

  const MediaItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class MediaItemRemoved extends MediaEvent {
  final String itemId;
  final String sectionId;

  const MediaItemRemoved(this.itemId, this.sectionId);

  @override
  List<Object?> get props => [itemId, sectionId];
}

class MediaItemMoved extends MediaEvent {
  final MediaItem item;
  final String fromSectionId;
  final String toSectionId;

  const MediaItemMoved(this.item, this.fromSectionId, this.toSectionId);

  @override
  List<Object?> get props => [item, fromSectionId, toSectionId];
}

class MediaSectionsReordered extends MediaEvent {
  final List<Section> sections;

  const MediaSectionsReordered(this.sections);

  @override
  List<Object?> get props => [sections];
}