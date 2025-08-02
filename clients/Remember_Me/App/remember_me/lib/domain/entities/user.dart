// lib/domain/entities/user.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final DateTime? emailVerified;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.emailVerified,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoURL,
        emailVerified,
        createdAt,
      ];

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    DateTime? emailVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}