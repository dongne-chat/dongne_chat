import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/ui/pages/create_chat/create_chat_view_model.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateChatPage extends ConsumerStatefulWidget {
  const CreateChatPage({super.key});

  @override
  ConsumerState createState() => _CreateChatPageState();
}

class _CreateChatPageState extends ConsumerState<CreateChatPage> {
  final loginUserId = '1';

  TextEditingController titleController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String selectedCategory = '전체'; // 기본값 '전체'

  @override
  void dispose() {
    titleController.dispose();
    infoController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  final _firestore = FirebaseFirestore.instance;

  void createChatRoom() {
    String title = titleController.text;
    String info = infoController.text;
    String category = selectedCategory;

    // TODO 로그인한 유저의 아이디 넣어주기
    _firestore.collection('chatRooms').add({
      'title': title,
      'info': info,
      'category': category,
      'users': [loginUserId], //.채팅방에 접속한 user_id 배열에 저장
      'address': '광주 봉선동', // 현재 좌표로 주소 찾아서 넣어주기
      // 'createdUser': 12,
      'createdAt': Timestamp.now() //날짜 추가
    });
  }

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(createChatViewModelProvider);
    String addressName = (vm != null) ? vm : "위치를 갱신해 주세요";

    void getAddressName() {
      ref.read(createChatViewModelProvider.notifier).searchByLatLng();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        title: Text(
          '채팅 생성',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: createChatRoom,
              child: Text(
                '완료',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '내위치',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                          getAddressName();
                        },
                        child: Icon(Icons.gps_fixed),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(addressName, style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            Container(
              height: 88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '채팅방 이름',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextField(controller: titleController),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '카테고리',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 40,
                    child: CategoryList(
                      onCategorySelected: updateCategory,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '설명',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextField(controller: infoController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
