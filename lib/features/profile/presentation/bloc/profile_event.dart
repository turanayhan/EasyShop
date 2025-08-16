import 'package:case1/features/auth/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// Kullanıcıyı yüklemek için
class LoadUser extends ProfileEvent {}



class RegisterUser extends ProfileEvent {
  final User user;

  const RegisterUser(this.user);

  @override
  List<Object?> get props => [user];
}

class PickProfileImage extends ProfileEvent {}
