import 'package:client/screens/list_screen.dart';
import 'package:client/screens/write_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${date.year}.${date.month}.${date.day}'),
                const Text('오늘은')
              ],
            ),
            FloatingActionButton(
              heroTag: 'write',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WriteScreen(),
                ),
              ),
              child: const Text('글 쓰기'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'list',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ListScreen(),
          ),
        ),
        child: const Text('목록 보기'),
      ),
    );
  }
}
