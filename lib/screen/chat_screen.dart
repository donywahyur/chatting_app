import 'package:chatting_app/widget/messages.dart';
import 'package:chatting_app/widget/new_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Chat"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: "logout",
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logout") {
                //logout
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessages()
          ],
        ),
      ),
    );
  }
}
