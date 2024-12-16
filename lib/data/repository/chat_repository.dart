import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_message.dart';

class ChatRepository {
  // 채팅방 메세지 불러오기
  Stream<List<ChatMessage>> getAllChatMessages(roomId) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('chatRooms').doc(roomId);

    return collectionRef
        .collection('messages')
        .orderBy('createdAt', descending: true) // 최신 메시지부터 가져오기
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  // 채팅방 메세지 전송
  Future<void> createMessage(roomId, content, senderId) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('chatRooms');

    collectionRef.doc(roomId).collection('messages').add({
      'content': content,
      'senderId': senderId,
      'createdAt': Timestamp.now(),
    });
  }
}
