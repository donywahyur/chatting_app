import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final firestore = FirebaseFirestore.instance;
  String _message = "";
  final Message = TextEditingController();
  void _sendMessage() {
    if (_message.isEmpty) return;

    FocusScope.of(context).unfocus();
    firestore.collection("chat").add({
      "text": _message,
      "createdAt": Timestamp.now(),
      "userId": FirebaseAuth.instance.currentUser!.uid,
    });
    setState(() {
      _message = "";
      Message.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: Message,
              decoration: const InputDecoration(
                  labelText: "Send a message...",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () {
              _sendMessage();
            },
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
