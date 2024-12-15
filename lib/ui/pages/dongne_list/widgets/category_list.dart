import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryList extends StatefulWidget {
  final List<String> categories = [
    '전체',
    '독서',
    '운동',
    '여행',
    '음악/악기',
    '봉사활동',
    '인문학',
    '문화/공연/축제',
    '자기계발',
    '공예/만들기',
    '사교/인맥',
  ];

  final Function(String) onCategorySelected;

  /// 카테고리 리스트
  CategoryList({super.key, required this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  void selectCategory(int value) {
    setState(() {
      selectedIndex = value;
    });
    // 선택된 카테고리 전달
    widget.onCategorySelected(widget.categories[value]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            selectCategory(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: (index == selectedIndex)
                  ? Theme.of(context).highlightColor
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                widget.categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (index == selectedIndex) ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 8),
    );
  }
}
