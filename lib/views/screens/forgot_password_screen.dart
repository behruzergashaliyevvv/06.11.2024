import 'package:dars/services/auth_http_services.dart';
import 'package:dars/views/screens/login_screen.dart';
import 'package:flutter/material.dart';


class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();

  String? email;
  bool isLoading = false;

  void resetPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.resetPassword(email!);

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Muvaffaqiyat"),
              content: const Text(
                  "Parolni yangilash uchun email manzilga yuborilgan ko'rsatmalarni bajaring."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: const Text("Tizimga kirish"),
                ),
              ],
            );
          },
        );
      } catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_NOT_FOUND")) {
          message = "Email topilmadi";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(
                  size: 90,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Elektron pochta",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos elektron pochtangizni kiriting";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    email = newValue;
                  },
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : FilledButton(
                        onPressed: resetPassword,
                        child: const Text("Parolni yangilash"),
                      ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text("Tizimga kirish"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return const ForgotScreen();
                            },
                          ),
                        );
                      },
                      child: const Text("Forgot password"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
