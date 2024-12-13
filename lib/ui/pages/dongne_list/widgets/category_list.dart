import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  List<String> categories = [
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

  /// 카테고리 리스트
  CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  void selectCategory(int value) {
    setState(() {
      selectedIndex = value;
    });
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
