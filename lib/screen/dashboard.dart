import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashBoardScreen extends StatefulWidget {
  final UserCredential userData;
  const DashBoardScreen({super.key, required this.userData});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();

      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userData);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                bool signout = await signOutFromGoogle();
                GoogleSignIn().disconnect();
                if (signout) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.userData.user!.photoURL!),
            radius: 50,
          ),
          // Image.network(widget.userData.user!.photoURL!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Name: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.userData.user!.displayName!,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Email: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.userData.user!.email!,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Phone Number: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.userData.user!.phoneNumber ?? "No Number Available",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Last Sign-in Date: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "${widget.userData.user!.metadata.lastSignInTime!.day}/${widget.userData.user!.metadata.lastSignInTime!.month}/${widget.userData.user!.metadata.lastSignInTime!.year}",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Last Sign-in Time: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "${widget.userData.user!.metadata.lastSignInTime!.hour}:${widget.userData.user!.metadata.lastSignInTime!.minute}:${widget.userData.user!.metadata.lastSignInTime!.second} IN UTC",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
