import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quest_04/constants/sizes.dart';
import 'package:quest_04/pages/chat_screen.dart';
import 'package:quest_04/pages/dongne_screen.dart';
import 'package:quest_04/pages/home_screen.dart';
import 'package:quest_04/widgets/nav_tab.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({
    super.key,
  });

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {

  int _selectedIndex = 0;

  void _onTap(int index) {
    if (index == 2 || index == 4) return;
    // context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      //   title: const Text('홈'),
      // ),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DongneScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ChatScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          bottom: Sizes.size32,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "홈",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "동네생활",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.mapLocationDot,
                selectedIcon: FontAwesomeIcons.mapLocationDot,
                onTap: () => _onTap(1),
              ),
              NavTab(
                text: "내 근처",
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.locationDot,
                selectedIcon: FontAwesomeIcons.locationDot,
                onTap: () => _onTap(2),
              ),
              NavTab(
                text: "채팅",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.comments,
                selectedIcon: FontAwesomeIcons.comments,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: "나의 당근",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.user,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
