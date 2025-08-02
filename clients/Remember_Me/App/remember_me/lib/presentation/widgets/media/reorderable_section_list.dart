import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/domain/entities/media_item.dart';
import '../../blocs/media/media_bloc.dart';
import '../../blocs/media/media_event.dart';
import 'media_section_card.dart';
import '../../../core/constants/app_constants.dart';

class ReorderableSectionList extends StatelessWidget {
  final List<Section> sections;

  const ReorderableSectionList({Key? key, required this.sections}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      itemCount: sections.length,
      onReorder: (oldIndex, newIndex) {
        final updatedSections = List<Section>.from(sections);
        if (newIndex > oldIndex) {
          newIndex--;
        }
        final section = updatedSections.removeAt(oldIndex);
        updatedSections.insert(newIndex, section);
        
        context.read<MediaBloc>().add(MediaSectionsReordered(updatedSections));
      },
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
          key: ValueKey(sections[index].id),
          index: index,
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: MediaSectionCard(
              section: sections[index],
              allSections: sections,
            ),
          ),
        );
      },
    );
  }
}