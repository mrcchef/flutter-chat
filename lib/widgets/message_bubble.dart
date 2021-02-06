import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  MessageBubble(this.message);
  // Constraints in flutter
  ///https://stackoverflow.com/questions/54717748/why-flutter-container-does-not-respects-its-width-and-height-constraints-when-it
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).accentColor,
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            message,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
