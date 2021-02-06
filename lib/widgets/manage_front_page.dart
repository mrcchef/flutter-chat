import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/auth_screen.dart';
import '../screens/chat_screen.dart';

class ManageFrontPage extends StatefulWidget {
  @override
  _ManageFrontPageState createState() => _ManageFrontPageState();
}

class _ManageFrontPageState extends State<ManageFrontPage> {
  bool isIntialize = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(
      () {
        setState(
          () {
            // print('Complete');
            isIntialize = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isIntialize
        ? StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (streamSnapshot.hasData) return ChatScreen();
              return AuthScreen();
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
