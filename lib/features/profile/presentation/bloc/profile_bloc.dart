import 'dart:io';

import 'package:case1/features/profile/data/profile_repository.dart';
import 'package:case1/features/profile/presentation/bloc/profile.state.dart';
import 'package:case1/features/profile/presentation/bloc/profile_event.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository repository;
   final ImagePicker _picker = ImagePicker();

  ProfileBloc(this.repository) : super(const ProfileState(isLoading: true)) {
    on<LoadUser>(_onLoadUser);
    on<RegisterUser>(_onRegisterUser);
    on<PickProfileImage>(_onPickProfileImage);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await repository.getUser();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

   Future<void> _onPickProfileImage(PickProfileImage event, Emitter<ProfileState> emit) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        emit(state.copyWith(profileImage: file));
        // Burada istersen repository'ye upload işlemi de yaptırabilirsin
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onRegisterUser(RegisterUser event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final success = await repository.register(event.user);
      if (success) {
        final user = await repository.getUser();
        emit(state.copyWith(user: user, isLoading: false));
      } else {
        emit(state.copyWith(error: 'Email already exists', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
