import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/data/models/media_item_model.dart';
import 'package:remember_me/domain/entities/media_item.dart';
import 'package:remember_me/domain/enums.dart';
import 'media_event.dart';
import 'media_state.dart';
import '../../../core/utils/helpers.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaInitial()) {
    on<MediaLoadRequested>(_onLoadRequested);
    on<MediaItemAdded>(_onItemAdded);
    on<MediaItemRemoved>(_onItemRemoved);
    on<MediaItemMoved>(_onItemMoved);
    on<MediaSectionsReordered>(_onSectionsReordered);
  }

  Future<void> _onLoadRequested(
    MediaLoadRequested event,
    Emitter<MediaState> emit,
  ) async {
    emit(MediaLoading());
    
    try {
      // Initialize with default sections and sample data
      final sections = _initializeSections();
      emit(MediaLoaded(sections));
    } catch (e) {
      emit(MediaError('Failed to load media sections: $e'));
    }
  }

  Future<void> _onItemAdded(
    MediaItemAdded event,
    Emitter<MediaState> emit,
  ) async {
    if (state is MediaLoaded) {
      final currentState = state as MediaLoaded;
      final sections = List<Section>.from(currentState.sections);
      
      // Find target section based on media type
      final targetSectionId = Helpers.getSectionIdForType(event.item.type);
      final sectionIndex = sections.indexWhere((s) => s.id == targetSectionId);
      
      if (sectionIndex != -1) {
        final section = sections[sectionIndex];
        final updatedItems = List<MediaItem>.from(section.items)..add(event.item);
        sections[sectionIndex] = section.copyWith(items: updatedItems);
        
        emit(MediaLoaded(sections));
      }
    }
  }

  Future<void> _onItemRemoved(
    MediaItemRemoved event,
    Emitter<MediaState> emit,
  ) async {
    if (state is MediaLoaded) {
      final currentState = state as MediaLoaded;
      final sections = List<Section>.from(currentState.sections);
      
      final sectionIndex = sections.indexWhere((s) => s.id == event.sectionId);
      if (sectionIndex != -1) {
        final section = sections[sectionIndex];
        final updatedItems = section.items.where((item) => item.id != event.itemId).toList();
        sections[sectionIndex] = section.copyWith(items: updatedItems);
        
        emit(MediaLoaded(sections));
      }
    }
  }

  Future<void> _onItemMoved(
    MediaItemMoved event,
    Emitter<MediaState> emit,
  ) async {
    if (state is MediaLoaded) {
      final currentState = state as MediaLoaded;
      final sections = List<Section>.from(currentState.sections);
      
      // Remove from source section
      final fromSectionIndex = sections.indexWhere((s) => s.id == event.fromSectionId);
      if (fromSectionIndex != -1) {
        final fromSection = sections[fromSectionIndex];
        final updatedFromItems = fromSection.items.where((item) => item.id != event.item.id).toList();
        sections[fromSectionIndex] = fromSection.copyWith(items: updatedFromItems);
      }
      
      // Add to target section
      final toSectionIndex = sections.indexWhere((s) => s.id == event.toSectionId);
      if (toSectionIndex != -1) {
        final toSection = sections[toSectionIndex];
        final updatedToItems = List<MediaItem>.from(toSection.items)..add(event.item);
        sections[toSectionIndex] = toSection.copyWith(items: updatedToItems);
      }
      
      emit(MediaLoaded(sections));
    }
  }

  Future<void> _onSectionsReordered(
    MediaSectionsReordered event,
    Emitter<MediaState> emit,
  ) async {
    emit(MediaLoaded(event.sections));
  }

  List<Section> _initializeSections() {
    return [
      Section(
        id: 'videos',
        title: 'Videos',
        color: Colors.red.shade600,
        backgroundColor: Colors.red.shade50,
        icon: Icons.video_library,
        items: [
          MediaItem(
            id: '1',
            title: 'Intro Video.mp4',
            type: MediaType.video,
            description: 'Willkommensvideo für neue Nutzer',
            icon: Icons.play_circle,
            color: Colors.red.shade400,
            fileSize: 15728640, // 15 MB
            dateAdded: DateTime.now().subtract(Duration(days: 2)),
          ),
          MediaItem(
            id: '2',
            title: 'Tutorial Basics.mp4',
            type: MediaType.video,
            description: 'Grundlagen Tutorial',
            icon: Icons.play_circle,
            color: Colors.red.shade400,
            fileSize: 25165824, // 24 MB
            dateAdded: DateTime.now().subtract(Duration(days: 1)),
          ),
        ],
      ),
      Section(
        id: 'images',
        title: 'Bilder',
        color: Colors.green.shade600,
        backgroundColor: Colors.green.shade50,
        icon: Icons.photo_library,
        items: [
          MediaItem(
            id: '3',
            title: 'Company_Logo.png',
            type: MediaType.image,
            description: 'Hauptlogo der Firma',
            icon: Icons.image,
            color: Colors.green.shade400,
            fileSize: 245760, // 240 KB
            dateAdded: DateTime.now().subtract(Duration(days: 5)),
          ),
          MediaItem(
            id: '4',
            title: 'Header_Banner.jpg',
            type: MediaType.image,
            description: 'Website Header',
            icon: Icons.image,
            color: Colors.green.shade400,
            fileSize: 1048576, // 1 MB
            dateAdded: DateTime.now().subtract(Duration(days: 3)),
          ),
        ],
      ),
      Section(
        id: 'audio',
        title: 'Audio',
        color: Colors.purple.shade600,
        backgroundColor: Colors.purple.shade50,
        icon: Icons.audiotrack,
        items: [
          MediaItem(
            id: '5',
            title: 'Background_Music.mp3',
            type: MediaType.audio,
            description: 'Hintergrundmusik für Videos',
            icon: Icons.music_note,
            color: Colors.purple.shade400,
            fileSize: 5242880, // 5 MB
            dateAdded: DateTime.now().subtract(Duration(days: 4)),
          ),
        ],
      ),
    ];
  }
}
