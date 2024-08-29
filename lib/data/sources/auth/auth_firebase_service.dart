import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either> signin(SigninUserRequest signinUserRequest);
}

class AuthFirebaseServiceImplmentation extends AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserRequest.email, password: createUserRequest.password);

      FirebaseFirestore.instance
          .collection('Users')
          .add({'name': createUserRequest.fullName, 'email': data.user?.email});

      return const Right('Signup was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      }

      if (e.code == 'email-already-in-use') {
        message = 'An account already exist with that email';
      } else {
        message = e.message.toString();
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserRequest.email, password: signinUserRequest.password);

      return const Right('Signin was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'No user found with that email';
      }

      if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }

      return Left(message);
    }
  }
}
