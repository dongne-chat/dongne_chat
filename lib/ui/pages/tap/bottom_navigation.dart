import 'package:dongne_chat/ui/pages/tap/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigation extends StatefulWidget {
  /// 바텀 네비게이션 바
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    // TODO: 페이지 전환 기능 구현 필요
    return Consumer(
      builder: (context, ref, child){
        final currentIndex = ref.watch(homeViewModel);
        final viewModel = ref.read(homeViewModel.notifier);
      return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: viewModel.onIndexChanged,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_fill),
            label: 'CHAT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MYPAGE',
          ),
        ],
      );
  });
  }
}
