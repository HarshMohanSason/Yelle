import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yelle/Login/login_state_class.dart';


class SignUpService extends ChangeNotifier{

  LoginStateClass _state = const LoginStateClass(state: LoginStateEnum.idle);
  LoginStateClass get state => _state;

  Future<void> startSigningUpProcess(String firstName, String lastName, String emailAddress, String confirmPassword) async
  {
    _state = const LoginStateClass(state: LoginStateEnum.loading);
    notifyListeners();

    try{
      //create the user and sign in using firebase
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailAddress, password: confirmPassword);

      Map<String, dynamic> userData= {
        'firstName': firstName,
        'lastName': lastName,
        'emailAddress': emailAddress,
      };
      //upload the user information to firebase
      await FirebaseFirestore.instance.collection('usersInfo').doc(userCredential.user!.uid).set(userData);
      _state = const LoginStateClass(state: LoginStateEnum.loggedIn);
      notifyListeners();
    }
    on SocketException catch(e)
    {
      _state =  LoginStateClass(state: LoginStateEnum.error, errorMessage: e.message);
      notifyListeners();
    }
    catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.code);
            break;
          case 'invalid-email':
            _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.code);
            break;
          case 'user-not-found':
            _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.code);
            break;
          default:
            _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.code);
            break;
        }
      } else {
        _state = LoginStateClass(state: LoginStateEnum.error, errorMessage: e.toString());
      }
      notifyListeners();
  }
}
}