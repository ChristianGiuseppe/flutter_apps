import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _store = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
 
  String messageText;

  void getCurrenteUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    final messages = await _store.collection('messages').getDocuments();
    for (var message in messages.documents) {
      print(message.data);
    }
  }

  void getMessagesStream() async {
    await for (var snapshot in _store.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
    // Stream<QuerySnapshot> snapshots =  _store.collection('messages').snapshots()
    // snapshots.forEach((snap){
    //   snap.documents.forEach((message){
    //     print(message.data);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        messageText = value; //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      controller.clear();
                      _store.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email
                      }); //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
              stream: _store.collection('messages').snapshots(),
              builder: (context, snapshot) {
                bool isMe = false;
                List<BubbleText> messageWidgets = [];
                if (snapshot.hasData) {
                  final messages = snapshot.data.documents.reversed;
                  for (var message in messages) {
                    final messageText = message.data['text'];
                    final senderText = message.data['senders'];
                    
                    final currentUser = loggedInUser.email;
                    if(currentUser == senderText){
                      isMe = true;
                    }

                    final messageWidget = BubbleText(
                        messageText: messageText, senderText: senderText, isMe: isMe);

                    messageWidgets.add(messageWidget);
                  }
                }
                return Expanded(
                  
                  child: ListView(
                    reverse: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageWidgets,
                  ),
                );
              },
            );
  }
}

class BubbleText extends StatelessWidget {
  const BubbleText({Key key, this.messageText, this.senderText, this.isMe})
      : super(key: key);

  final String messageText;
  final String senderText;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          '$senderText',
          style: TextStyle(color: Colors.black54, fontSize: 12.0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Text(
              '$messageText',
              style: TextStyle(color: isMe ? Colors.white : Colors.black54, fontSize: 15.0),
            ),
          ),
        ),
      ],
    );
  }
}
