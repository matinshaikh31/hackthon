class SettingModel {
  final List<String> images;
  final List<String> categories;
  final String title;
  final String description;

  SettingModel({
    required this.images,
    required this.title,
    required this.description,
    required this.categories,
  });

  factory SettingModel.fromSnapshot(Map<String, dynamic> json) {
    return SettingModel(
      images: List<String>.from(json['images'] ?? []),
      categories: List<String>.from(json['categories'] ?? []),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'images': images,
    'categories': categories,
    'title': title,
    'description': description,
  };

  Map<String, dynamic> toJson() => toMap();
}
