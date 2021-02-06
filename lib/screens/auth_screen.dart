import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for onPlatformException
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/build_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  void submitAuthData(String emailId, String userName, String password,
      File pickedImage, bool isLogin, BuildContext ctx) async {
    setState(() {
      isLoading = true;
    });
    await Firebase.initializeApp();
    final _auth = FirebaseAuth.instance; // returns the instance of Auth class
    UserCredential _authResult;
    try {
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: emailId, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: emailId, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authResult.user.uid)
            .set({
          'emailId': emailId,
          'userName': userName,
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(_auth.currentUser.uid + '.jpg');

        await ref.putFile(pickedImage).whenComplete(() => null);
      }
    } on PlatformException catch (err) {
      String message =
          "Oops!! Something went wrong. Please check your credentials";
      if (err.message != null) message = err.message;

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (err) {
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(err.message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      // print(err.message);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: BuildForm(submitAuthData, isLoading),
          ),
        ),
      ),
    );
  }
}
