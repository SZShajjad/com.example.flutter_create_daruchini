import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/errors/failures.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  StreamSubscription<User?>? _authSub;
  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isEmailVerified => _user?.emailVerified ?? false;

  AuthProvider() {
    _authSub = _auth.authStateChanges().listen((User? user) async {
      _user = user;
      if (user != null) {
        await _storage.write(key: 'last_login_email', value: user.email);
        await _storage.write(
            key: 'auth_provider',
            value: user.providerData.firstOrNull?.providerId);
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  Future<void> sendEmailVerification() async {
    await _user?.sendEmailVerification();
  }

  Future<void> reloadUser() async {
    await _user?.reload();
    _user = _auth.currentUser;
    notifyListeners();
  }

  Future<Failure?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return AuthFailure.fromCode(e.code);
    } catch (e) {
      return const ServerFailure(
          'An unexpected error occurred during sign up.');
    }
  }

  Future<Failure?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return AuthFailure.fromCode(e.code);
    } catch (e) {
      return const ServerFailure(
          'An unexpected error occurred during sign in.');
    }
  }

  Future<Failure?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      notifyListeners();
      return null;
    } on GoogleSignInException catch (e) {
      // In v7.x, we check logic
      if (e.toString().toLowerCase().contains('canceled')) {
        return const AuthFailure('canceled', 'Sign-in cancelled.');
      }
      return const AuthFailure('google-sign-in', 'Google Sign-In failed.');
    } on FirebaseAuthException catch (e) {
      return AuthFailure.fromCode(e.code);
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return const ServerFailure(
          'An unexpected error occurred with Google Sign-In.');
    }
  }

  Future<Failure?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (_) {
      // Always return success to prevent account enumeration.
      return null;
    } catch (e) {
      return const ServerFailure('An unexpected error occurred.');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      debugPrint("Sign out error: $e");
    }
  }
}
