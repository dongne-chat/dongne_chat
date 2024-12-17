import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/ui/pages/chat/chat_page.dart';
import 'package:dongne_chat/ui/pages/homepage/widget/home_page_chat_list.dart';
import 'package:dongne_chat/ui/widgets/create_chat_room_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });

    if (userId != null) {
    _loadProfileImage(userId!); // 프로필 이미지 로드
  }
  }

  Stream<QuerySnapshot> _chatRoomsStream(String userId) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .where('users', arrayContains: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
  Future<void> _loadProfileImage(String userId) async {
    try {
      final imageUrl = await FirebaseStorage.instance
          .ref()
          .child('profile_images/$userId.jpg')
          .getDownloadURL();
      setState(() {
        profileImageUrl = imageUrl;
      });
    } catch (e) {
      print("이미지 로드 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff466995),
        title: Text(
          "Dongne_talk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey,
              image: profileImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(profileImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profileImageUrl == null
                ? Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 20),
          Container(
            width: 125,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff8CA9CD),
            ),
            child: Center(
              child: Text(
                userId ?? "",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 2.0,
              width: double.infinity,
              color: Color(0xff466995),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "참여중인 방",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: userId == null
                ? Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
                    stream: _chatRoomsStream(userId!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("참여중인 채팅방이 없습니다."));
                      } else {
                        final chatRooms = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: chatRooms.length,
                          itemBuilder: (context, index) {
                            final chatRoom = chatRooms[index];
                            final chatRoomName = chatRoom['title'] ?? '채팅방 이름 없음';
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      roomId: chatRoom.id,
                                      title: chatRoomName,
                                      userId: userId!,
                                    ),
                                  ),
                                );
                              },
                              child: homepagechatlist(
                                roomId: chatRoom.id,
                                title: chatRoomName,
                                category: chatRoom["category"],
                                userCount: chatRoom['users'].length,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: CreateChatRoomButton(userId: userId),
    );
  }
}
