import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  DocumentSnapshot doc;


  ChatPage({required this.doc});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {// Stores chat messages
  final TextEditingController messageController = TextEditingController(); // Controller for TextField


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: widget.doc.reference.collection('messages').orderBy('time').snapshots(),
                builder: (context , snapshot)
                {
                  if(snapshot.hasData){
                    if(snapshot.data?.docs.isEmpty ?? true){
                      return Text("No message yet !");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? 0
                    ,itemBuilder: (context, index){
                        DocumentSnapshot msg = snapshot.data!.docs[index];
                        if (msg['uid'] == FirebaseAuth.instance.currentUser!.uid){
                          // my message
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.all(4.0),

                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade100,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  msg['message'].toString(),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          );

                        }else{
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(4.0),

                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  msg['message'].toString(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          );
                        }
                        return Text(msg.data().toString());

                    });
                  }else{
                    return SizedBox(width:25, height: 25, child: CircularProgressIndicator());
                  }

                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async{
                    widget.doc.reference.collection('messages').add({
                      'time' : DateTime.now(),
                      'uid':  FirebaseAuth.instance.currentUser!.uid,
                      'message': messageController.text,
                    });

                    messageController.text = "";
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
