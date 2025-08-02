import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:remember_me/data/models/media_item_model.dart';

class Section extends Equatable {
  final String id;
  final String title;
  final Color color;
  final Color backgroundColor;
  final IconData icon;
  final List<MediaItem> items;

  const Section({
    required this.id,
    required this.title,
    required this.color,
    required this.backgroundColor,
    required this.icon,
    required this.items,
  });

  Section copyWith({
    String? id,
    String? title,
    Color? color,
    Color? backgroundColor,
    IconData? icon,
    List<MediaItem>? items,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      icon: icon ?? this.icon,
      // WICHTIGER FIX: Korrekte Handhabung der items Liste
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [id, title, color, backgroundColor, icon, items];

  @override
  String toString() => 'Section(id: $id, title: $title, itemCount: ${items.length})';
}