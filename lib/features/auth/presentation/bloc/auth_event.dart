import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

// Login
class LoginEmailChanged extends AuthEvent {
  final String email;
  const LoginEmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends AuthEvent {
  final String password;
  const LoginPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends AuthEvent {}

// Register
class RegisterNameChanged extends AuthEvent {
  final String name;
  const RegisterNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class RegisterPhoneChanged extends AuthEvent {
  final String phone;
  const RegisterPhoneChanged(this.phone);
  @override
  List<Object?> get props => [phone];
}

class RegisterEmailChanged extends AuthEvent {
  final String email;
  const RegisterEmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends AuthEvent {
  final String password;
  const RegisterPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class RegisterSubmitted extends AuthEvent {}

// Splash ekranında login durumunu kontrol etmek için ekleniyor
class CheckLoginStatus extends AuthEvent {}

class AppStarted extends AuthEvent {}
