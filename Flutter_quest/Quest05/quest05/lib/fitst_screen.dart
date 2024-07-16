// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JellyfishClassifier extends StatefulWidget {
  const JellyfishClassifier({super.key});

  @override
  State<JellyfishClassifier> createState() => _JellyfishClassifierState();
}

class _JellyfishClassifierState extends State<JellyfishClassifier> {
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
  final String url = '9a6a-124-56-101-127.ngrok-free.app'; // 서버 url
  String text = '';

  void _onBtnClick(String str) async {
    Uri uri = Uri.https(url, '/$str');
    var response = await http.get(uri);
    final result = jsonDecode(response.body)['predicted_$str'];
    setState(() {
      text = '예측 결과 : $result';
    });
    print(text);
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
              SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => _onBtnClick('label'),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(''), // 인퍼런스
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _onBtnClick('score'),
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

/*
회고
AI 모델의 결과값을 api를 통해 flutter client까지 전달하는 과정을 진행했습니다.
과정을 진행하며 AI 모델부터 client까지 데이터 전달 흐름을 파악할 수 있었습니다.
특히 AI 모델의 결과값을 서버에서 보내주는 것은 처음이었기에 공부가 많이 되었습니다.
 */