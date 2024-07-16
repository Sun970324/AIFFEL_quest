// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const JellyfishClassifier());
}

class JellyfishClassifier extends StatelessWidget {
  const JellyfishClassifier({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _imagePath = 'assets/image/jellyfish.jpg'; // 예시 이미지

  void _onLeftButtonPressed() async {
    // 이미지를 불러와서 인퍼런스하고 출력값을 콘솔에 출력하는 코드 추가
    String url = '9a6a-124-56-101-127.ngrok-free.app';
    Uri uri = Uri.https(url, '/label');
    var response = await http.get(uri);
    final result = jsonDecode(response.body)['predicted_label'];
    print('예측 결과 : $result 클래스'); // print('예측 결과 : ${} 클래스');
  }

  void _onRightButtonPressed() async {
    String url = '9a6a-124-56-101-127.ngrok-free.app';
    Uri uri = Uri.https(url, '/score');
    var response = await http.get(uri);
    final result = jsonDecode(response.body)['prediction_score'];
    print('$result 확률로 예측했습니다.'); // print('${} 확률로 예측했습니다.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.animation_outlined),
        title: const Text('Jellyfish Classifier'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Image.asset(_imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: _onLeftButtonPressed,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(''), // 인퍼런스
                  ),
                  ElevatedButton.icon(
                    onPressed: _onRightButtonPressed,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(''),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
