import 'package:dars/controllers/course_controller.dart';
import 'package:dars/controllers/note_controller.dart';
import 'package:dars/controllers/plan_controller.dart';
import 'package:dars/notifier/theme_notifier.dart';
import 'package:dars/provider/basket_course_provider.dart';
import 'package:dars/provider/buy_course_provider.dart';
import 'package:dars/provider/favorite_course_provider.dart';
import 'package:dars/services/auth_http_services.dart';
import 'package:dars/views/screens/basket_screen.dart';
import 'package:dars/views/screens/buy_screen.dart';
import 'package:dars/views/screens/favorite_screen.dart';
import 'package:dars/views/screens/home_screen.dart';
import 'package:dars/views/screens/note_screen.dart';
import 'package:dars/views/screens/plans_screen.dart';
import 'package:dars/views/screens/settings_screen.dart';
import 'package:dars/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteController()),
        ChangeNotifierProvider(create: (_) => PlanController()),
        ChangeNotifierProvider(create: (_) => CourseController()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => FavoriteCoursesProvider()),
        ChangeNotifierProvider(create: (_) => BuyCourseProvider()),
        ChangeNotifierProvider(create: (_) => BasketCourseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authHttpServices = AuthHttpServices();
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    authHttpServices.checkAuth().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeNotifier.currentTheme,
      //
      //
      home: isLoggedIn ? HomeScreen() : SplashScreen(),
      //
      //
      routes: {
        '/notes': (context) => NoteScreen(),
        '/plans': (context) => PlansScreen(),
        '/basket': (context) => BasketScreen(),
        '/favorites': (context) => FavoriteScreen(),
        '/buy': (context) => BuyScreen(),
        '/settings': (context) =>
            SettingsScreen(toggleTheme: themeNotifier.toggleTheme),
      },
    );
  }
}
