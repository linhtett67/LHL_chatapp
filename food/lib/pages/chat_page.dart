import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/components/chat_bubble.dart';
import 'package:food/components/mytextfield.dart';
import 'package:food/services/auth/auth_service.dart';
import 'package:food/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverMail;
  final String receiverID;
  ChatPage({super.key, required this.receiverMail, required this.receiverID});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // get instance of firestore & auth
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send message
  void sendMessage() async {
    // only send if there is text in the textfield
    if(_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      // clear the textfield
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverMail)),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput()
        ],
      ),
    );
  }
  
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    List<String> ids = [senderID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return StreamBuilder(
      
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if(snapshot.hasError) {
          return const Text("Error");
        }

        // loeading
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // return list view
        return Text(
          // children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          chatRoomID,
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(message:  data['message'], isCurrentUser: isCurrentUser,)
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // textfield should take up most of the space
          Expanded(
            child: MyTextField(
              hintText: "Type a message", 
              obscureText: false, 
              controller: _messageController
            )
          ),
      
          Container(
            decoration: const BoxDecoration(
              color: Colors.green, 
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white,)
            ),
          )
        ],
      ),
    );
  }
}