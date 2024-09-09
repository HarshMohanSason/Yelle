import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yelle/Login/login_state_class.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth =
      FirebaseAuth.instance; //firebase auth instance
  final GoogleSignIn googleSignIn = GoogleSignIn(); //google Sign in instance

  LoginStateClass _state = const LoginStateClass(state: LoginStateEnum.idle);

  LoginStateClass get state => _state;

  String? _provider;

  String? get provider => _provider;

  String? _uid;

  String? get uid => _uid;

  String? _username;

  String? get username => _username;

  String? _email;

  String? get email => _email;

  String? _imageURL;

  String? get imageURL => _imageURL;

  //Future function to signInWithGoogle
  Future startSignInWithGoogle() async {
    _state = const LoginStateClass(state: LoginStateEnum.loading);
    notifyListeners();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn(); //Start the signIn process

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        //sign in to firebase using the user Instance
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;

        _username = userDetails.displayName;
        _email = userDetails.email;
        _imageURL = userDetails.photoURL;
        _uid = userDetails.uid;
        _provider = "GOOGLE";
        _state = const LoginStateClass(state: LoginStateEnum.loggedIn);
        notifyListeners();

        if (!await checkUserExists()) //check if the userExists in firestore or not, else logout
        {
          await saveDataToFirestore();
        }

        //catch any errors when logging the user in
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "An account already exists with the same email address but different sign-in credentials.");
            break;

          case "invalid-credential":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "The credential data is malformed or has expired.");
            break;

          case "operation-not-allowed":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "This type of account is not enabled. Enable it in the Firebase Console.");
            break;

          case "user-disabled":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "The user account has been disabled by an administrator.");
            break;

          case "user-not-found":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "No user corresponding to this identifier. The user may have been deleted.");
            break;

          case "wrong-password":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "The password is invalid or the user does not have a password.");
            break;

          case "invalid-verification-code":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage: "The verification code provided is invalid.");
            break;

          case "invalid-verification-id":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage: "The verification ID provided is invalid.");
            break;

          case "credential-already-in-use":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "This credential is already associated with a different user account.");
            break;

          case "weak-password":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage: "The password provided is too weak.");
            break;

          case "email-already-in-use":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "The email address is already in use by another account.");
            break;

          case "invalid-email":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage: "The email address is badly formatted.");
            break;

          case "network-request-failed":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "A network error occurred (e.g., timeout, interrupted connection).");
            break;

          case "too-many-requests":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "We have blocked all requests from this device due to unusual activity. Try again later.");
            break;

          case "user-token-expired":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "The user's credential is no longer valid. The user must sign in again.");
            break;

          case "user-mismatch":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "The supplied credentials do not correspond to the previously signed-in user.");
            break;

          case "requires-recent-login":
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage:
                    "This operation is sensitive and requires recent authentication. Log in again before retrying this request.");
            break;

          default:
            _state = const LoginStateClass(
                state: LoginStateEnum.error,
                errorMessage: "An undefined Error happened.");
            break;
        }
        notifyListeners();
      }
    }else{
      _state = const LoginStateClass(
          state: LoginStateEnum.idle,
      );
    }
  }

  //Function to sign the userOUT
  /*Future signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    _isSignedIn = false;
    _isLoading = false;
    await storage.delete(key: 'LoggedIn');
    notifyListeners();
  }

   */

  //check if the userExists already
  Future<bool> checkUserExists() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        return true;
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 14.0,
      );
      return false;
    }
  }

  //Get user Data from Firestore
  Future getUserDataFromFirestore(uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(uid)
          .get()
          .then((snapshot) {
        _uid = snapshot["uid"];
        _username = snapshot["username"];
        _email = snapshot["email"];
        _imageURL = snapshot["imageURL"];
        _provider = snapshot["provider"];
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 14.0,
      );
      return null;
    }
  }

  //Function to save the Data to the firestore database
  Future saveDataToFirestore() async {
    try {
      final docSnapshot =
          FirebaseFirestore.instance.collection('usersInfo').doc(uid);
      await docSnapshot.set({
        "username": _username,
        "email": _email,
        "imageURL": _imageURL,
        "uid": _uid,
        "provider": _provider,
      });
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 14.0,
      );
    }
  }

/* Future deleteGoogleRelatedAccount() async {
    try {

      await FirebaseFirestore.instance.collection('userInfo').doc(
          firebaseAuth.currentUser!.uid).delete();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await storage.deleteAll(); // Assuming storage is an instance of your local storage handler
      await signOut();
      showToast('Your account and data have been deleted'.tr(), Colors.green, Colors.white, 'LONG');

    } on SocketException {
      showToast(
          'Check your Internet Connection'.tr(), Colors.red, Colors.white, 'SHORT');
    }
    catch (e) {
      showToast('An error occurred, please try again'.tr(), Colors.red, Colors.white, 'SHORT');
    }
  }

  */
}
