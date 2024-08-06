class DiaryModel {
  final String content;
  final String createdAt;

  DiaryModel({
    required this.content,
    required this.createdAt,
  });

  DiaryModel.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "createdAt": createdAt,
    };
  }

  DiaryModel copyWith({
    String? uid,
    String? content,
    String? createdAt,
  }) {
    return DiaryModel(
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
