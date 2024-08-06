import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewScreen extends ConsumerWidget {
  final String content;
  final String date;

  const ViewScreen({
    super.key,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: size.height * 0.5,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Text(content),
        ),
      ),
    );
  }
}
