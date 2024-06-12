import 'package:dars/controllers/course_controller.dart';
import 'package:dars/provider/basket_course_provider.dart';

import 'package:dars/provider/favorite_course_provider.dart';
import 'package:dars/services/auth_http_services.dart';
import 'package:dars/services/products_http_services.dart';
import 'package:dars/views/screens/basket_screen.dart';
import 'package:dars/views/screens/buy_screen.dart';
import 'package:dars/views/screens/course_video_page.dart';
import 'package:dars/views/screens/favorite_screen.dart';
import 'package:dars/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productController = TextEditingController();

  final productsHttpServices = ProductsHttpServices();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool showTextFields = false;

  void addProduct() async {
    await productsHttpServices.addProduct(productController.text);
    setState(() {});
  }

  void toggleTextFields() {
    setState(() {
      showTextFields = !showTextFields;
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseController = Provider.of<CourseController>(context);
    final favoriteCoursesProvider =
        Provider.of<FavoriteCoursesProvider>(context);
    final basketProvider = Provider.of<BasketCourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Bosh Sahifa"),
        actions: [
          IconButton(
            icon: Icon(showTextFields ? Icons.close : Icons.add),
            onPressed: toggleTextFields,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Notes'),
              onTap: () {
                Navigator.pushNamed(context, '/notes');
              },
            ),
            ListTile(
              title: const Text('Plans'),
              onTap: () {
                Navigator.pushNamed(context, '/plans');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: const Text('Savatcha'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BasketScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Sevimlilar',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ));
              },
            ),
            ListTile(
              title: const Text(
                'Sotib olingan',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyScreen(),
                    ));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: IconButton(
                    onPressed: () {
                      AuthHttpServices.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Visibility(
              visible: showTextFields,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      courseController.addCourse(
                        titleController.text,
                        amountController.text,
                        imageUrlController.text,
                        [],
                        double.parse(priceController.text),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Add Course'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: courseController.courses.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                        childAspectRatio: 2 / 3.4,
                      ),
                      itemCount: courseController.courses.length,
                      itemBuilder: (context, index) {
                        final course = courseController.courses[index];
                        final isInBasket =
                            basketProvider.basketCourses.contains(course);
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CourseVideoPage(course: course),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 130,
                                      child: Image.network(
                                        course.imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        course.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          favoriteCoursesProvider
                                              .toggleFavoriteStatus(course);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: course.isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        course.description,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          basketProvider
                                              .toggleBasketStatus(course);
                                        },
                                        icon: Icon(
                                          Icons.shopping_basket_outlined,
                                          color: course.isInBasket
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${course.price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          courseController
                                              .deleteCourse(course.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
