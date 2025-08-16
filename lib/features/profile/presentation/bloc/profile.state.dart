import 'package:case1/features/auth/data/model/user_model.dart';


import 'dart:io';

class ProfileState {
  final User? user;
  final bool isLoading;
  final String? error;
  final File? profileImage;  // <-- yeni alan

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
    this.profileImage,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    File? profileImage,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

