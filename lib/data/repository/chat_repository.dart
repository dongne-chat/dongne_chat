import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_message.dart';
import 'package:dongne_chat/data/model/user.dart';

class ChatRepository {
  // 채팅방 메세지 불러오기
  Stream<List<ChatMessage>> getAllChatMessages(String roomId) {
    try {
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
    } catch (e) {
      print(e);
      return Stream.value([]);
    }
  }

  // 채팅방 메세지 전송
  Future<void> createMessage(
      String roomId, String content, String senderId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('chatRooms');

      collectionRef.doc(roomId).collection('messages').add({
        'content': content,
        'senderId': senderId,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  // user의 데이터 가져오는 메서드
  Future<List<User?>> getUserData(String id) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('users');
      final result = await collectionRef.where('id', isEqualTo: id).get();

      final docs = result.docs;
      if (docs.isNotEmpty) {
        return docs.map((doc) => User.fromMap(doc.data())).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

// roomId를 기준으로 채팅방 참여한 사람들의 id인 users 데이터 가져오기
  Future<List<String>?> fetchUsersArray(String roomId) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('chatRooms');
    final docSnapshot = await collectionRef.doc(roomId).get();

    if (docSnapshot.exists) {
      final chatUsers = List<String>.from(docSnapshot['users']);
      return chatUsers;
    }
    return null;
  }

  // users에 있는 사용자의 정보 가져오기
  Future<Map<String, User>?> fetchUsersData(List<String>? chatUsers) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('users');
    final querySnapshot = await collectionRef
        .where(FieldPath.documentId, whereIn: chatUsers)
        .get();

    final docs = querySnapshot.docs;
    if (docs.isNotEmpty) {
      final users = docs.map((doc) => User.fromMap(doc.data())).toList();
      var userMap = {for (var user in users) user.id: user};
      return userMap;
    }
    return null;
  }
}
