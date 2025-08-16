import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String loginEmail;
  final String loginPassword;
  final String registerName;
  final String registerPhone;
  final String registerEmail;
  final String registerPassword;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const AuthState({
    this.loginEmail = '',
    this.loginPassword = '',
    this.registerName = '',
    this.registerPhone = '',
    this.registerEmail = '',
    this.registerPassword = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  AuthState copyWith({
    String? loginEmail,
    String? loginPassword,
    String? registerName,
    String? registerPhone,
    String? registerEmail,
    String? registerPassword,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return AuthState(
      loginEmail: loginEmail ?? this.loginEmail,
      loginPassword: loginPassword ?? this.loginPassword,
      registerName: registerName ?? this.registerName,
      registerPhone: registerPhone ?? this.registerPhone,
      registerEmail: registerEmail ?? this.registerEmail,
      registerPassword: registerPassword ?? this.registerPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loginEmail,
    loginPassword,
    registerName,
    registerPhone,
    registerEmail,
    registerPassword,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}
