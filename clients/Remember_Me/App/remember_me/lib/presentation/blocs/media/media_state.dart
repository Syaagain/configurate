import 'package:equatable/equatable.dart';
import 'package:remember_me/domain/entities/media_item.dart';

abstract class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object?> get props => [];
}

class MediaInitial extends MediaState {}

class MediaLoading extends MediaState {}

class MediaLoaded extends MediaState {
  final List<Section> sections;

  const MediaLoaded(this.sections);

  @override
  List<Object?> get props => [sections];
}

class MediaError extends MediaState {
  final String message;

  const MediaError(this.message);

  @override
  List<Object?> get props => [message];
}