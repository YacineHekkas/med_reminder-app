import 'dart:convert';
import 'package:flutter/material.dart'; // Import Material.dart to use BuildContext
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import '../model/advice.dart';
import '../model/foodSuggestions.dart';
import '../model/recipe.dart';

class DataService {
  static Future<Map<String, dynamic>> _loadJsonData(BuildContext context) async {
    final easyLocalization = EasyLocalization.of(context);
    final locale = easyLocalization?.locale ?? Locale('en');
    final String jsonString = await rootBundle.loadString('assets/translations/${locale.languageCode}.json');
    return json.decode(jsonString);
  }

  static Future<List<Recipe>> getRecipes(BuildContext context) async {
    final data = await _loadJsonData(context);
    return (data['recipes'] as List).map((recipeJson) => Recipe.fromJson(recipeJson)).toList();
  }

  static Future<List<FoodSuggestions>> getFoodSuggestions(BuildContext context) async {
    final data = await _loadJsonData(context);
    return (data['foodSuggestions'] as List).map((suggestionJson) => FoodSuggestions.fromJson(suggestionJson)).toList();
  }

  static Future<List<Advice>> getAdvices(BuildContext context) async {
    final data = await _loadJsonData(context);
    return (data['advices'] as List).map((adviceJson) => Advice.fromJson(adviceJson)).toList();
  }
}