import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find<AuthRepo>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Check if user is signed in
  bool get isAuthenticated => _auth.currentUser != null;

  /// Get current user
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL); // only for web
    // screenRedirect();  // this dont work in web
    log('isAuthenticated  =>  $isAuthenticated');
    super.onReady();
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  /// Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // User is signed in, navigate to the home screen
      Get.offAllNamed(HRoutes.dashboard);
    } else {
      // User is not signed in, navigate to the login screen
      Get.offAllNamed(HRoutes.login);
    }
  }
}
