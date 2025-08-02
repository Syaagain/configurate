import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/data/models/media_item_model.dart';
import 'package:remember_me/presentation/widgets/media/media_item_tile.dart';
import '../../blocs/media/media_bloc.dart';
import '../../blocs/media/media_event.dart';
import '../../../domain/entities/media_item.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/strings.dart';

class MediaSectionCard extends StatelessWidget {
  final Section section;
  final List<Section> allSections;

  const MediaSectionCard({
    Key? key,
    required this.section,
    required this.allSections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      shadowColor: section.color.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              section.backgroundColor,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            _buildSectionHeader(),
            _buildItemsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: section.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.borderRadius),
          topRight: Radius.circular(AppConstants.borderRadius),
        ),
      ),
      child: Row(
        children: [
          Icon(section.icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              section.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: Text(
              '${section.items.length}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8),
          _buildDragIndicator(),
        ],
      ),
    );
  }

  Widget _buildDragIndicator() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: List.generate(3, (index) => Container(
          width: 20,
          height: 2,
          margin: EdgeInsets.symmetric(vertical: 1.5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(1),
          ),
        )),
      ),
    );
  }

  Widget _buildItemsList(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120,
        maxHeight: section.items.isEmpty ? 120 : 300,
      ),
      child: DragTarget<Map<String, dynamic>>(
        onAccept: (data) {
          final sourceId = data['sourceSection'] as String;
          final item = data['item'] as MediaItem;
          
          if (sourceId != section.id) {
            context.read<MediaBloc>().add(MediaItemMoved(item, sourceId, section.id));
          }
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            margin: EdgeInsets.all(AppConstants.smallPadding),
            decoration: BoxDecoration(
              color: candidateData.isNotEmpty 
                  ? section.color.withOpacity(0.1)
                  : Colors.transparent,
              border: candidateData.isNotEmpty
                  ? Border.all(color: section.color, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: section.items.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(AppConstants.smallPadding),
                    itemCount: section.items.length,
                    itemBuilder: (context, index) {
                      return MediaItemTile(
                        item: section.items[index],
                        section: section,
                        onDelete: () => _deleteItem(context, section.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            section.icon,
            size: 48,
            color: section.color.withOpacity(0.3),
          ),
          SizedBox(height: 12),
          Text(
            'Keine ${section.title}',
            style: TextStyle(
              color: section.color.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            AppStrings.dragItemsHere,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteItem(BuildContext context, MediaItem item) {
    context.read<MediaBloc>().add(MediaItemRemoved(item.id, section.id));
  }
}