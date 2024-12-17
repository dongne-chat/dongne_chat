import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget senderMessage(
    {senderNickname, senderProfileImgUrl, senderId, content, createdAt}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      senderProfileImgUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.square(
                dimension: 50,
                child: Image.network(
                  senderProfileImgUrl,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 50,
                height: 50,
              )),
      Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Text(
                '$senderNickname',
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
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text('$content',
                          softWrap: true, overflow: TextOverflow.visible)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
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
