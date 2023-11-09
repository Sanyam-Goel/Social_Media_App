import 'dart:developer';
import 'dart:typed_data';
//import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    return model.User.fromSnap(snap);
  }
  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        log(cred.user!.uid);
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        //ADD user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email  : email,
          photoUrl  : photoUrl,
          bio  : bio,
          followers  : []  ,
          following  : []  ,
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        res = "success";
      }
    } 
    // on FirebaseAuthException catch(err){
    //   if(err.code == 'invalid-email'){
    //     res = 'the email is badly formatted.';
    //   }
    //   else if(err.code == 'weak-password'){
    //     res = 'Password should be at least 6 characters';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      }
      else{
        res= "Please enter all the fields";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
// if(kIsWeb){
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: "AIzaSyAvt2zK0NsVXllvehIEP0v9qp8SYulbSGI", 
//         appId: "1:492773426029:web:cb1053aa0c2788f6971064",
//         messagingSenderId: "492773426029",
//         projectId: "instagram-tut-8a877",
//         storageBucket: "instagram-tut-8a877.appspot.com",
//       ),
//     );
//   }
//   else{
//     await Firebase.initializeApp();
//   }
