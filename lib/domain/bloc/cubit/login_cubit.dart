import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/firebase_auth_repository.dart';
import '../state/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  LoginCubit({required FirebaseAuthRepository firebaseAuthRepository})
      : _firebaseAuthRepository = firebaseAuthRepository,
        super(LoginState.initial());

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoginState.loading());
    try {
      await _firebaseAuthRepository.signInWithEmailAndPassword(email, password);
      emit(LoginState.success());
    } on Exception catch (e) {
      emit(LoginState.error(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(LoginState.loading());
    try {
      await _firebaseAuthRepository.signUpWithEmailAndPassword(email, password);
      emit(LoginState.success());
    } on Exception catch (e) {
      emit(LoginState.error(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _firebaseAuthRepository.signOut();
    emit(LoginState.initial());
  }
}