import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Messages extends StatelessWidget {
  Messages({super.key});

  final Stream<QuerySnapshot> _chatStream = FirebaseFirestore.instance
      .collection("chat")
      .orderBy('createdAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _chatStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: Text("No connection"));
          } else if (snapshot.connectionState == ConnectionState.active) {
            final chatList = snapshot.data!.docs;
            return ListView.builder(
                reverse: true,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final isMe = chatList[index]['userId'] ==
                      FirebaseAuth.instance.currentUser!.uid;

                  return Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: isMe ? Colors.blue[400] : Colors.grey[500],
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(chatList[index]['text'],
                            overflow: TextOverflow.clip,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                });
          } else {
            return const Center(child: Text("Unknown error"));
          }
        });
  }
}
