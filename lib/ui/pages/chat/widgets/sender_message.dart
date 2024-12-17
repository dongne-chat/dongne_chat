import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget senderMessage(senderId, content, createdAt) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox.square(
          dimension: 50,
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
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Text(
                '$senderId',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  constraints: BoxConstraints(
                    maxWidth: 250, // Container의 최대 너비를 설정
                  ),
                  // height: 35,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Text('$content',
                          softWrap: true, overflow: TextOverflow.visible)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    DateFormat('HH:mm')
                        .format(DateTime.parse(createdAt.toString())),
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
