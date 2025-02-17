import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:untitled_med/view/widgets/foodSuggestions.dart';
import 'package:untitled_med/view/widgets/recipeCard.dart';
import '../constant/colors.dart';
import '../controllers/data_controller.dart';
import '../model/foodSuggestions.dart';
import '../model/recipe.dart';

class PlannerMenuScreen extends StatefulWidget {
  const PlannerMenuScreen({Key? key}) : super(key: key);

  @override
  _PlannerMenuScreenState createState() => _PlannerMenuScreenState();
}

class _PlannerMenuScreenState extends State<PlannerMenuScreen> {
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
      appBar: AppBar(
          backgroundColor: AppColors.backgroundColor
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(), // Add this line

          slivers: [
            // Sliver for Breakfast Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text(
                  "Idea_for_Breakfast".tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            // Sliver for Lunch Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text(
                  "Idea_for_Lunch".tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            // Sliver for Snack Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text(
                  "Idea_for_Snack".tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            // Sliver for Dinner Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text(
                  "Idea_for_Dinner".tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}