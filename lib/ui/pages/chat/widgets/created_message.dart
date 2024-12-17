import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget createdMassage({content, createdAt}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Text(
              DateFormat('HH:mm').format(DateTime.parse(createdAt.toString())),
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            constraints: BoxConstraints(
              maxWidth: 250, // Container의 최대 너비를 설정
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('$content',
                    softWrap: true, // 텍스트가 자동으로 줄바꿈되도록 설정
                    overflow: TextOverflow
                        .visible) // 텍스트가 컨테이너를 넘어가지 않고, 아래줄로 내려가도록 보장합니다.
                ),
          )
        ],
      ),
    ],
  );
}
