class SettingModel {
  final List<String> images;
  final String title;
  final String description;

  SettingModel({
    required this.images,
    required this.title,
    required this.description,
  });

  factory SettingModel.fromSnapshot(Map<String, dynamic> json) {
    return SettingModel(
      images: List<String>.from(json['images'] ?? []),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'images': images,
    'title': title,
    'description': description,
  };

  Map<String, dynamic> toJson() => toMap();
}
