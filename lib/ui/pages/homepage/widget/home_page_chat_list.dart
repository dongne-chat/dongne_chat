import 'package:flutter/material.dart';

class homepagechatlist extends StatelessWidget {
  homepagechatlist({
    super.key,
    required this.roomId,
    required this.title,
    required this.category,
    required this.userCount
  });

  final roomId;
  final title;
  final category;
  final int userCount;

   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black38),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 80,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "참여자 수 : $userCount",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}