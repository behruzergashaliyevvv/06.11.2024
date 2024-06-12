import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dars/provider/buy_course_provider.dart';

class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boughtCourses = Provider.of<BuyCourseProvider>(context).boughtCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sotib Olingan Mahsulotlar'),
      ),
      body: boughtCourses.isEmpty
          ? const Center(child: Text('No courses bought yet.'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 2 / 2.8,
              ),
              itemCount: boughtCourses.length,
              itemBuilder: (context, index) {
                final course = boughtCourses[index];
                return Card(
                  elevation: 3.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          course.imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
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
                            Text("Price: \$${course.price}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
