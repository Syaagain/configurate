import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:remember_me/domain/enums.dart';

class MediaItem extends Equatable {
  final String id;
  final String title;
  final MediaType type;
  final String? description;
  final IconData icon;
  final Color color;
  final String? filePath;
  final int? fileSize;
  final DateTime dateAdded;

  const MediaItem({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    required this.icon,
    required this.color,
    this.filePath,
    this.fileSize,
    required this.dateAdded,
  });

  MediaItem copyWith({
    String? id,
    String? title,
    MediaType? type,
    String? description,
    IconData? icon,
    Color? color,
    String? filePath,
    int? fileSize,
    DateTime? dateAdded,
  }) {
    return MediaItem(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        description,
        icon,
        color,
        filePath,
        fileSize,
        dateAdded,
      ];
}