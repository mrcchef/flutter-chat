import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AddNewMessage extends StatefulWidget {
  @override
  _AddNewMessageState createState() => _AddNewMessageState();
}

class _AddNewMessageState extends State<AddNewMessage> {
  var _messageController = new TextEditingController();
  var _message = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _messageController.clear(); // This will clear the text on the TextField
    Firebase.initializeApp();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _message,
        'timeStamp': Timestamp.now(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: "Send a message..."),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          SizedBox(
            width: 5,
          ),
          RaisedButton(
            child: Icon(
              Icons.send,
            ),
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
