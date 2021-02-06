import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/messages.dart';
import '../widgets/add_messages.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemValue) {
              if (itemValue == 'logout') FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          AddNewMessage(),
        ],
      ),
    );
  }
}
