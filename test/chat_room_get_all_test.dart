// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dongne_chat/data/model/chat_room.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:dongne_chat/firebase_options.dart';
//
// void main() {
//   setUpAll(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await dotenv.load(fileName: ".env");
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   });
//
//   test('DongneList getAll Test', () async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('chatRooms')
//         .orderBy('createdAt', descending: true)
//         .get();
//
//     final chatRooms =
//         snapshot.docs.map((doc) => ChatRoom.fromJson(doc)).toList();
//
//     expect(chatRooms.isEmpty, false);
//
//     for (var room in chatRooms) {
//       print(room);
//     }
//   });
// }
