import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:flutter/material.dart';

/// 채팅방 바텀 모달
Future<dynamic> showModalBottom(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
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
                    '채팅방 이름',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // TODO: 채팅방 입장 기능 구현 필요
                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>));
                      },
                      child: Text(
                        '입장',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).highlightColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ],
              ),
              SizedBox(height: 16),
              Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ),
              ),
              // CategoryList(),
              SizedBox(height: 8),
              Text(
                '채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 '
                '설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 '
                '설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명 채팅방 설명',
                maxLines: 2,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        );
      });
}
