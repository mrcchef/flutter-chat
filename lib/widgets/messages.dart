import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool isIntialize = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {
        isIntialize = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isIntialize
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('timeStamp',
                    descending:
                        true) // We are getting the list according to the timeStamp field
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final chatDocs = snapshot.data.docs;
              return ListView.builder(
                reverse:
                    true, // This will build the widget return by itemBuilder fron reverse order
                itemBuilder: (ctx, index) {
                  final _userId = FirebaseAuth.instance.currentUser.uid;
                  return MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['userId'] == _userId,
                    chatDocs[index]['userName'],
                    // key: ValueKey(chatDocs[index].documentID),
                  );
                },
                itemCount: chatDocs.length,
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
