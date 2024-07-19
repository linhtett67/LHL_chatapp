import 'package:flutter/material.dart';
import 'package:food/components/user_tile,.dart';
import 'package:food/pages/chat_page.dart';
import 'package:food/services/auth/auth_service.dart';
import 'package:food/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();



  // logout function
  void logout() {
    // auth service
    final authService = AuthService();

    authService.signOut();
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],),

      body: _buildUserList(),
    );
  }
  
  
  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // error
        if(snapshot.hasError) {
          return const Text("Error");
        }

        // loadiing
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      }
    );
  }


  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // display all uisers except current user
    if(userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"], 
        onTap: () {
          // tapped on a user -> go to chat page
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverMail: userData["email"],
                receiverID: userData["uid"],
              )
            )
          );
        }
      );
    } else {
      return Container();
    }
  }
}