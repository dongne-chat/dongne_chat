import 'package:dongne_chat/ui/pages/homepage/widget/home_page_chat_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            ),
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
                "아이디",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 2.0,
              width: double.infinity,
              color: Color(0xff466995),
            ),
          ),
          Text(
            "참여중인 방",
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  homepagechatlist(),
                  ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


