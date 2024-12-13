import 'package:dongne_chat/ui/pages/chat/widgets/chat_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Align(
                alignment: Alignment.centerLeft, child: Text('헬린이들 모여라~!')),
          ),
          bottomSheet: ChatBottomSheet(),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      reverse: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return senderMassageContainer();
                      }),
                ),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createdMassageContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '13:03',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              width: 170,
              height: 35,
            )
          ],
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }

  Widget senderMassageContainer() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox.square(
                dimension: 70,
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_1280.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Text(
                      '뚱냥이 집사',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    width: 200,
                    height: 35,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '13:01',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
