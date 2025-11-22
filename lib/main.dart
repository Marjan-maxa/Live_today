import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Sample JSON data
 String jsonData = '''
[
  {"id": 1, "title": "Chicken Biryani", "description": "Aromatic basmati rice cooked with spiced chicken.", "calories": 550},
  {"id": 2, "title": "Beef Curry", "description": "Slow-cooked beef in a rich curry gravy.", "calories": 620},
  {"id": 3, "title": "Vegetable Khichuri", "description": "Rice and lentils cooked with mixed vegetables.", "calories": 400},
  {"id": 4, "title": "Pasta Alfredo", "description": "Creamy white sauce pasta with parmesan cheese.", "calories": 480},
  {"id": 5, "title": "Grilled Sandwich", "description": "Toasted sandwich filled with cheese and vegetables.", "calories": 310},
  {"id": 6, "title": "Chicken Fry", "description": "Crispy deep-fried chicken with spices.", "calories": 530},
  {"id": 7, "title": "Egg Curry", "description": "Boiled eggs cooked in masala gravy.", "calories": 450},
  {"id": 8, "title": "Fruit Salad", "description": "Mixed seasonal fruits served chilled.", "calories": 250},
  {"id": 9, "title": "Fried Rice", "description": "Rice fried with vegetables, egg, and soy sauce.", "calories": 500},
  {"id": 10, "title": "Mango Lassi", "description": "Sweet yogurt drink blended with ripe mango.", "calories": 300}
]
''';


class Recipe {
  final int id;
  final String title;
  final String description;
  final int calories;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.calories,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      calories: json['calories'],
    );
  }
}

List<Recipe> parseRecipes(String jsonStr) {
  final List<dynamic> jsonList = json.decode(jsonStr);
  return jsonList.map((item) => Recipe.fromJson(item)).toList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Recipe List',
      debugShowCheckedModeBanner: false,
      home: RecipeListScreen(),
    );
  }
}

// Recipe List Screen
class RecipeListScreen extends StatelessWidget {
  final List<Recipe> recipes = parseRecipes(jsonData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          final Color cardColor = index % 2 == 0 ? Colors.lightBlue.shade50 : Colors.orange.shade50;
          return Card(
            color: cardColor,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(child: Text(recipe.id.toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
              trailing: Text('Calories: ${recipe.calories} kcal'),
              title: Text(recipe.title,style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${recipe.description}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
