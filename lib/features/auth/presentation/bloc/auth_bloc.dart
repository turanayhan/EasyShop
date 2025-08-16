import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../data/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    // App start - check if already logged in
    on<AppStarted>((event, emit) {
      if (authRepository.isLoggedIn()) {
        emit(state.copyWith(isSuccess: true));
      }
    });

    // Login Email
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(loginEmail: event.email));
    });

    // Login Password
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(loginPassword: event.password));
    });

    // Login Submit
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      try {
        final success = await authRepository.login(
          state.loginEmail,
          state.loginPassword,
        );
        if (success) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'E-posta veya şifre hatalı.',
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    // Register Name
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(registerName: event.name));
    });

    // Register Phone
    on<RegisterPhoneChanged>((event, emit) {
      emit(state.copyWith(registerPhone: event.phone));
    });

    // Register Email
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(registerEmail: event.email));
    });

    // Register Password
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(registerPassword: event.password));
    });

    // Register Submit
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      try {
        final success = await authRepository.register(
          state.registerName,
          state.registerPhone,
          state.registerEmail,
          state.registerPassword,
        );
        if (success) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Kayıt sırasında hata oluştu.',
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
