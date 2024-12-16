import 'package:dongne_chat/ui/pages/tap/bottom_navigation.dart';
import 'package:dongne_chat/ui/pages/tap/home_indexed_stack.dart';
import 'package:flutter/material.dart';

class TapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeIndexedStack(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
