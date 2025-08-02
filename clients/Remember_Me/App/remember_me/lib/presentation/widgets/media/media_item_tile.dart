import 'package:flutter/material.dart';
import 'package:remember_me/data/models/media_item_model.dart';
import '../../../domain/entities/media_item.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/strings.dart';

class MediaItemTile extends StatelessWidget {
  final MediaItem item;
  final Section section;
  final VoidCallback onDelete;

  const MediaItemTile({
    Key? key,
    required this.item,
    required this.section,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<Map<String, dynamic>>(
      data: {
        'item': item,
        'sourceSection': section.id,
      },
      feedback: Material(
        elevation: AppConstants.cardElevation,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          width: 320,
          padding: EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(color: item.color, width: 2),
          ),
          child: Row(
            children: [
              Icon(item.icon, color: item.color, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (item.description != null)
                      Text(
                        item.description!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.none),
        ),
        child: Center(
          child: Text(
            'Wird verschoben...',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.smallPadding),
          leading: Container(
            padding: EdgeInsets.all(AppConstants.smallPadding),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.smallPadding),
            ),
            child: Icon(item.icon, color: item.color, size: 24),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.description != null)
                Text(
                  item.description!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              SizedBox(height: 4),
              Row(
                children: [
                  if (item.fileSize != null)
                    Text(
                      Formatters.formatFileSize(item.fileSize!),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (item.fileSize != null) Text(' • ', style: TextStyle(color: Colors.grey.shade400)),
                  Text(
                    Formatters.formatDateSimple(item.dateAdded),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.grey.shade400),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    SizedBox(width: 8),
                    Text(AppStrings.details),
                  ],
                ),
                value: 'info',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.download, size: 20),
                    SizedBox(width: 8),
                    Text(AppStrings.download),
                  ],
                ),
                value: 'download',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text(AppStrings.delete, style: TextStyle(color: Colors.red)),
                  ],
                ),
                value: 'delete',
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                onDelete();
              } else if (value == 'info') {
                _showItemDetails(context);
              }
            },
          ),
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${AppStrings.details}: ${item.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.description != null) Text('Beschreibung: ${item.description}'),
            if (item.fileSize != null) Text('Größe: ${Formatters.formatFileSize(item.fileSize!)}'),
            Text('Typ: ${item.type.toString().split('.').last}'),
            Text('Hinzugefügt: ${Formatters.formatDate(item.dateAdded)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.close),
          ),
        ],
      ),
    );
  }
}