class Recipe {
  final String id;
  final String title;
  final String description;
  final double price;
  final String cookingTime;
  final String imageUrl;
  final double rating;
  final String category;
  final List<String> ingredients;
  final List<String> toppings;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.cookingTime,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.ingredients,
    required this.toppings,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      cookingTime: json['cookingTime'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      category: json['category'],
      ingredients: List<String>.from(json['ingredients']),
      toppings: List<String>.from(json['toppings']),
    );
  }
}