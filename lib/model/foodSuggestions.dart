class FoodSuggestions {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  FoodSuggestions({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory FoodSuggestions.fromJson(Map<String, dynamic> json) {
    return FoodSuggestions(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}