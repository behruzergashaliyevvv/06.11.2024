import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dars/provider/basket_course_provider.dart';
import 'package:dars/provider/buy_course_provider.dart';

class BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final basketCourses = Provider.of<BasketCourseProvider>(context).basketCourses;
    final buyCourseProvider = Provider.of<BuyCourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sevimlilar'),
      ),
      body: basketCourses.isEmpty
          ? const Center(child: Text('No basket courses yet.'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 2 / 2.8,
              ),
              itemCount: basketCourses.length,
              itemBuilder: (context, index) {
                final course = basketCourses[index];
                final isBought = buyCourseProvider.boughtCourses.contains(course);
                return GestureDetector(
                  onTap: () {
                    // Handle tapping on a basket course
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
                                course.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text("Amount: ${course.description}"),
                              Text("Price: ${course.price}"),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: isBought
                                        ? null
                                        : () {
                                            buyCourseProvider.addBoughtCourse(course);
                                          },
                                    child: const Text("Buy"),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        isBought ? Colors.grey : Colors.blue,
                                      ),
                                      foregroundColor: MaterialStateProperty.all<Color>(
                                        Colors.white,
                                      ),
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
