import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../page_chat/chat_page.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('chats')
              .where('users',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.docs.isEmpty ?? true) {
                return Text("No Chat");
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];

                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(doc: doc)));
                      },
                      title: Text("data"),
                      subtitle: Text(doc['recent_text']),
                      trailing: Icon(Icons.arrow_forward_ios),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
