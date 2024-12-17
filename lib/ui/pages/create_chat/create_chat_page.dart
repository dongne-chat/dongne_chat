import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/core/validator/create_chat_validator.dart';
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

  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController infoController = TextEditingController();

  String selectedCategory = '전체'; // 기본값 '전체'
  String addressName = '';

  @override
  void dispose() {
    titleController.dispose();
    infoController.dispose();
    super.dispose();
  }

  final _firestore = FirebaseFirestore.instance;

  void createChatRoom() async {
    String title = titleController.text;
    String info = infoController.text;
    String category = selectedCategory;
    print('$title $info');
    // TODO: validator 넣어야 함
    // TODO: user 똑바로 넣어야 함
    CreateChatViewModel().createChat(
      title: title,
      info: info,
      category: category,
      users: ['z'],
      address: addressName,
      createdUser: 'z',
    );
  }

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(createChatViewModelProvider);
    addressName = (vm != null) ? vm : "";

    void getAddressName() {
      ref.read(createChatViewModelProvider.notifier).searchByLatLng();
    }

    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
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
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      createChatRoom();
                      Navigator.pop(context);
                    }
                  },
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
                  height: 103,
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
                  height: 105,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '채팅방 이름',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: titleController,
                        validator: CreateChatValidator.validatorTitle,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 103,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '카테고리',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
                  height: 103,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '설명',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: infoController,
                        validator: CreateChatValidator.validatorInfo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
