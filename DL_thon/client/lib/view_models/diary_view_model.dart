import 'dart:async';

import 'package:client/models/diary_model.dart';
import 'package:client/repos/diary_repo.dart';
import 'package:riverpod/riverpod.dart';

class DiaryViewModel extends AsyncNotifier<List<DiaryModel>> {
  late final DiaryRepository _repository;

  Future<List<DiaryModel>> _fetchDiaries() async {
    state = const AsyncValue.loading();
    final result = await _repository.fetchDiaries();
    final diaries = result.docs
        .map(
          (doc) => DiaryModel.fromJson(doc.data()),
        )
        .toList();
    return diaries;
  }

  @override
  FutureOr<List<DiaryModel>> build() async {
    _repository = ref.read(diaryRepo);
    return await _fetchDiaries();
  }

  Future<void> createDiary(String content) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final diary = DiaryModel(
        content: content,
        createdAt: DateTime.now().toString(),
      );
      await _repository.createDiary(diary);
      final result = await _repository.fetchDiaries();
      final diaries = result.docs
          .map(
            (doc) => DiaryModel.fromJson(doc.data()),
          )
          .toList();
      return diaries;
    });
  }
}

final diaryProvider = AsyncNotifierProvider<DiaryViewModel, List<DiaryModel>>(
  () => DiaryViewModel(),
);
