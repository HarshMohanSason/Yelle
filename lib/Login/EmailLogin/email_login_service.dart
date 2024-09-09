import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:yelle/Login/login_state_class.dart';

class EmailLoginService extends ChangeNotifier {

  LoginStateClass _state  = const LoginStateClass(state: LoginStateEnum.idle);
  LoginStateClass get state => _state;

  Future startEmailLoginProcess(String emailAddress, String password) async
  {
    _state = const LoginStateClass(state: LoginStateEnum.loading);
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      _state = const LoginStateClass(state: LoginStateEnum.loggedIn);
      notifyListeners();
    }
    on SocketException catch(e) {
      _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
      notifyListeners();
    }
    catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
            break;
          case 'user-not-found':
            _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
            break;
          case 'wrong-password':
            _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
            break;
          case 'user-disabled':
            _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
            break;
          case 'too-many-requests':
            _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
            break;
          case 'operation-not-allowed':
            _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
            break;
          default:
            _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
        }
      } else {
        _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.toString());
      }
      notifyListeners();
    }
  }

}
