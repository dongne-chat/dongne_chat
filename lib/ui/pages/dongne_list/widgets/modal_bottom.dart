import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/ui/pages/chat/chat_page.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:flutter/material.dart';

/// 채팅방 바텀 모달
Future<dynamic> showModalBottom(BuildContext context, String roomId,
    String title, String info, String category) {
  final _firestore = FirebaseFirestore.instance;

// TODO // 로그인한 유저의 값넣기
  void insertUserIdIntoChatPage() {
    _firestore.collection('chatRooms').doc(roomId).update({
      'users': FieldValue.arrayUnion(['2']) // 로그인한 유저의 값넣기
    });
  }

  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            bottom: 0,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // 채팅방으로 이동 시 버튼 내리기
                      insertUserIdIntoChatPage();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(roomId: roomId, title: title)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).highlightColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '입장',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ),
              ),
              // CategoryList(),
              SizedBox(height: 8),
              Text(
                info,
                maxLines: null,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      });
}
