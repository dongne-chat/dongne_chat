import 'package:dongne_chat/ui/pages/dongne_list/widgets/modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DongneListItem extends StatelessWidget {
  final roomId;
  final title;
  final info;
  final category;
  final createdAt;
  final userId;

  /// 채팅방 리스트
  // const DongneListItem({super.key});
  const DongneListItem({
    super.key,
    required this.roomId,
    required this.title,
    required this.info,
    required this.category,
    required this.createdAt,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // DateTime으로 파싱
    DateTime parsedDate = DateTime.parse(createdAt.toString());

    return GestureDetector(
      onTap: () {
        showModalBottom(context, roomId, title, info, category, userId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat('yy-MM-dd').format(parsedDate),
                      style: TextStyle(fontSize: 13)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$info',
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
