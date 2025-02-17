import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constant/colors.dart';
import '../controllers/data_controller.dart';
import '../model/foodSuggestions.dart';
import '../model/recipe.dart';

import '../widgets/foodSuggestions.dart';
import '../widgets/recipeCard.dart';


class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<List<Recipe>> _recipesFuture;
  late Future<List<FoodSuggestions>> _foodSuggestionsFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _recipesFuture = DataService.getRecipes(context);
    _foodSuggestionsFuture = DataService.getFoodSuggestions(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data when locale changes
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "list_of_recipes".tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
                child: FutureBuilder<List<Recipe>>(
                  future: _recipesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(recipe: snapshot.data![index]);
                        },
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "dietary_recommendations".tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: FutureBuilder<List<FoodSuggestions>>(
                  future: _foodSuggestionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return FoodSuggestionCard(
                            suggestion: snapshot.data![index],
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}