import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_room.dart';

class DongneListRepository {
  // 채팅름 목록을 가져오는 스트림 메서드
  Stream<List<ChatRoom>> getAllChatRooms() {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('chatRooms');

      return collectionRef
          .orderBy('createdAt', descending: true) // 내림차순 정렬
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => ChatRoom.fromJson(doc)).toList();
      });
    } catch (e) {
      print(e);
      return Stream.value([]);
    }
  }

  // 채팅룸 생성
  Future<void> createChatRoom(
      title, info, category, userId, addressName) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('chatRooms');

      collectionRef.add({
        'title': title,
        'info': info,
        'category': category,
        'users': [userId], // 채팅방에 접속한 user_id 배열에 저장
        'address': addressName, // 현재 좌표로 주소 찾아서 넣어주기
        'createdAt': Timestamp.now()
      });
    } catch (e) {
      print(e);
    }
  }

  // 채팅방 입장 시 user_id 삽입
  Future<void> insertUserId(roomId, userId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('chatRooms');

      collectionRef.doc(roomId).update({
        'users': FieldValue.arrayUnion([userId])
      });
    } catch (e) {
      print(e);
    }
  }

  // 채팅방 가져오기
  Future<List<ChatRoom>?> getAll({
    required String address,
    required String? category,
  }) async {
    category = category ?? '천체'; // 기본값 설정
    try {
      var query = FirebaseFirestore.instance
          .collection('chatRooms')
          .where('address', isEqualTo: address)
          .orderBy('createdAt', descending: true);

      if (category != '전체') {
        query = query.where('category', isEqualTo: category);
      }

      final snapshot = await query.get();

      final chatRooms =
          snapshot.docs.map((doc) => ChatRoom.fromJson(doc)).toList();
      return chatRooms;
    } catch (e) {
      print("DongneListRepository : $e");
    }
  }

  // 채팅방 생성
  Future<bool> create(
      {required String title,
      required String info,
      required String category,
      required List users,
      required String address,
      required String createdUser}) async {
    try {
      //
      FirebaseFirestore.instance.collection('chatRooms').add({
        'title': title,
        'info': info,
        'category': category,
        'users': users,
        'address': address,
        'createdUser': createdUser,
        'createdAt': Timestamp.now(),
      });
      return true;
    } catch (e) {
      //
      return false;
    }
  }
}
