import 'package:dongne_chat/ui/pages/dongne_list/widgets/modal_bottom.dart';
import 'package:flutter/material.dart';

class DongneListItem extends StatelessWidget {
  /// 채팅방 리스트
  const DongneListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottom(context);
      },
      child: Container(
        height: 80,
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '채팅방 이름',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '마지막 채팅 내용 마지막 채팅 내용 마지막 채팅 내용 '
                    '마지막 채팅 내용 마지막 채팅 내용',
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: Text('오후 8:50', style: TextStyle(fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
