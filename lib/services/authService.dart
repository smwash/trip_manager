import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trip_manager/models/user.dart';
import 'package:trip_manager/services/database.dart';

class AuthService {
  var errorMessage = '';
  final _db = Database();
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  //user:
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  //get user:
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //google signIn:
  Future googleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      final googleAuth = await account.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      AuthResult authResult = await _auth.signInWithCredential(credential);

      //add user to db:
      var user = User(
        userEmail: account.email,
        userId: authResult.user.uid,
        profilePic: account.photoUrl,
        userName: account.displayName,
      );
      _db.addUser(user);
      return _userFromFirebase(authResult.user);
    } catch (error) {}
  }

  //SignUp
  Future signUpUser({
    String email,
    String password,
    String username,
    String profilePic,
  }) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //username:
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = username;
      await authResult.user.updateProfile(userUpdateInfo);
      await authResult.user.reload();

      //adding user to firestore:
      var user = User(
        userEmail: email,
        userName: username,
        userId: authResult.user.uid,
        profilePic: '',
      );
      _db.addUser(user);
      return _userFromFirebase(authResult.user);
    } on PlatformException catch (error) {
      if (error != null) {
        errorMessage = error.message;
      }
    } catch (error) {}
  }

  //login User:
  Future loginUser({
    String email,
    String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (error) {
      if (error != null) {
        errorMessage = error.message;
      }
    } catch (error) {}
  }

  Future logOutUser() async {
    try {
      await _auth.signOut();
    } catch (err) {}
  }
}
