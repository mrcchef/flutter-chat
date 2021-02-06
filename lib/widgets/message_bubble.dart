import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  // final Key key;
  MessageBubble(this.message, this.isMe, this.userName);
  // Constraints in flutter
  ///https://stackoverflow.com/questions/54717748/why-flutter-container-does-not-respects-its-width-and-height-constraints-when-it
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.black : Colors.white),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
