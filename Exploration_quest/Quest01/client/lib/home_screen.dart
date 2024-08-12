import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _imageFile;
  String _predictedClass = '';

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
        _predictedClass = '';
      });
      // await predictImage();
    }
  }

  Future<void> predictImage() async {
    // if (_imageFile == null) return;
    final base64Image = await encodeImage(_imageFile!);
    print(base64Image);
    final url = Uri.parse('https://4bad-124-56-101-127.ngrok-free.app/predict');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({'image': base64Image}),
    );
    // print(response);
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   setState(() {
    //     _predictedClass = '예측된 꽃: ${data['predicted']}';
    //   });
    // } else {
    //   print('Error: ${response.statusCode}');
    // }
  }

  Future<String> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('꽃 사진 분류'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_imageFile != null) Image.file(_imageFile!),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('사진 선택'),
              ),
              if (_imageFile != null)
                ElevatedButton(
                    onPressed: predictImage, child: const Text("예측하기")),
              Text(_predictedClass),
            ],
          ),
        ),
      ),
    );
  }
}
