import 'package:audioplayers/audioplayers.dart';
import 'package:client/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  final List<Map<String, String>> prompt;
  const SecondScreen({
    super.key,
    required this.prompt,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late AudioPlayer audioPlayer;
  String? audioFilePath;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void generateMusic() async {
      setState(() {
        isLoading = true;
      });
      Uri uri =
          Uri.https('467d-124-56-101-127.ngrok-free.app', '/generate_music', {
        'genre': widget.prompt[0]['value'],
        'tempo': widget.prompt[1]['value'],
        'mood': widget.prompt[2]['value'],
      });
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        // final dir = await getTemporaryDirectory();
        // final file = File('${dir.path}/generated_music.wav');
        // await file.writeAsBytes(response.bodyBytes);
        // setState(() {
        //   audioFilePath = file.path;
        //   isLoading = false;
        // });
        // await audioPlayer.play(AssetSource(file.path));
        print(response.body);
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to generate music');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('음악 생성하기')),
      body: Center(
        child: Center(
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "선택된 키워드는 '${widget.prompt[0]['name']}, ${widget.prompt[1]['name']}, ${widget.prompt[2]['name']}'입니다.\n 생성하시겠습니까?",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const CircularProgressIndicator(),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "선택된 키워드는 '${widget.prompt[0]['name']}, ${widget.prompt[1]['name']}, ${widget.prompt[2]['name']}'입니다.\n 생성하시겠습니까?",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (audioFilePath != null)
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              audioPlayer.resume();
                            },
                            child: const Text('Play'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              audioPlayer.pause();
                            },
                            child: const Text('Pause'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              audioPlayer.stop();
                            },
                            child: const Text('Stop'),
                          ),
                        ],
                      ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: Sizes.size40,
          top: Sizes.size16,
          left: Sizes.size24,
          right: Sizes.size24,
        ),
        child: GestureDetector(
          onTap: () => generateMusic(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16 + Sizes.size2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              '생성',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.size16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
