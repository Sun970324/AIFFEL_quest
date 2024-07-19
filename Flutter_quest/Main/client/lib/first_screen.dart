import 'package:client/constants/gaps.dart';
import 'package:client/constants/sizes.dart';
import 'package:client/interest_button.dart';
import 'package:client/second_screen.dart';
import 'package:flutter/material.dart';

const genreList = [
  {"name": "발라드", "value": "ballad"},
  {"name": "락", "value": "rock"},
  {"name": "팝", "value": "pop"},
  {"name": "컨트리", "value": "country"},
  {"name": "힙합", "value": "hiphop"},
  {"name": "재즈", "value": "jazz"},
  {"name": "클래식", "value": "classical"},
  {"name": "펑크", "value": "funk"},
  {"name": "트로트", "value": "trot"},
  {"name": "시티팝", "value": "citypop"},
  {"name": "댄스", "value": "dance"},
  {"name": "Lo-Fi", "value": "lofi"},
];
const tempoList = [
  {"name": "매우 빠름", "value": "very fast"},
  {"name": "빠름", "value": "fast"},
  {"name": "보통", "value": "medium"},
  {"name": "느림", "value": "slow"},
  {"name": "매우 느림", "value": "very slow"},
];
const moodList = [
  {"name": "행복한", "value": "happy"},
  {"name": "우울한", "value": "sad"},
  {"name": "슬픈", "value": "sorrowful"},
  {"name": "추억의", "value": "nostalgic"},
  {"name": "신나는", "value": "exciting"},
];

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<FirstScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showTitle = false;
  int? _isSelectedGenre;
  int? _isSelectedTempo;
  int? _isSelectedMood;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onTapGenre(int index) {
    setState(() {
      _isSelectedGenre = index;
    });
  }

  void _onTapTempo(int index) {
    setState(() {
      _isSelectedTempo = index;
    });
  }

  void _onTapMood(int index) {
    setState(() {
      _isSelectedMood = index;
    });
  }

  void _onNextTap() {
    if (_isSelectedGenre != null &&
        _isSelectedTempo != null &&
        _isSelectedMood != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            prompt: [
              genreList[_isSelectedGenre!],
              tempoList[_isSelectedTempo!],
              moodList[_isSelectedMood!]
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Text("장르 선택하기"),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  "내게 맞는 음악 취향을 고르세요.",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  "취향에 맞는 음악을 AI가 만들어드립니다!",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v48,
                const Text(
                  "장르를 선택해주세요.",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v24,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (var i = 0; i < genreList.length; i++)
                      GestureDetector(
                        onTap: () => _onTapGenre(i),
                        child: InterestButton(
                          genre: genreList[i]['name']!,
                          isSelected: i == _isSelectedGenre,
                        ),
                      )
                  ],
                ),
                Gaps.v48,
                const Text(
                  "템포를 선택해주세요.",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v24,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (var i = 0; i < tempoList.length; i++)
                      GestureDetector(
                        onTap: () => _onTapTempo(i),
                        child: InterestButton(
                          genre: tempoList[i]['name']!,
                          isSelected: i == _isSelectedTempo,
                        ),
                      )
                  ],
                ),
                Gaps.v48,
                const Text(
                  "분위기를 선택해주세요.",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v24,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (var i = 0; i < moodList.length; i++)
                      GestureDetector(
                        onTap: () => _onTapMood(i),
                        child: InterestButton(
                          genre: moodList[i]['name']!,
                          isSelected: i == _isSelectedMood,
                        ),
                      )
                  ],
                )
              ],
            ),
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
          onTap: _onNextTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16 + Sizes.size2,
            ),
            decoration: BoxDecoration(
              color: _isSelectedGenre != null &&
                      _isSelectedTempo != null &&
                      _isSelectedMood != null
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            child: const Text(
              'Next',
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
