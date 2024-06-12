import 'package:dars/provider/favorite_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteCourses =
        Provider.of<FavoriteCoursesProvider>(context).favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sevimlilar'),
      ),
      body: favoriteCourses.isEmpty
          ? Center(child: Text('No favorite courses yet.'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Display two items per row
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 2 / 2.8,
              ),
              itemCount: favoriteCourses.length,
              itemBuilder: (context, index) {
                final course = favoriteCourses[index];
                return GestureDetector(
                  onTap: () {
                    // Handle tapping on a favorite course
                  },
                  child: Card(
                    elevation: 3.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.network(
                                course.imageUrl,
                                fit: BoxFit.contain,
                                height: 135,
                                width: 135,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${course.title}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text("Amount: ${course.description}"),
                              Text("Price: ${course.price}"),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Your onPressed function
                                    },
                                    child: Text("Buy"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
