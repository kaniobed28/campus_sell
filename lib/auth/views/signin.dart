import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signup.dart';
import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key})
      : emailOfFormController = TextEditingController(),
        passwordOfFormController = TextEditingController(),
        super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordOfFormController;
  final TextEditingController emailOfFormController;
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double widtht_of_screen = MediaQuery.of(context).size.width;
    double height_of_screen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: authController.isAuthenticated.isTrue
          ?  NewDashboard()
          : Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: widtht_of_screen,
                    height: height_of_screen,
                    padding: const EdgeInsets.all(10),
                    color: Colors.blueGrey[50],
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopify_rounded,
                            size: 80,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Add functionality to the IconButton if needed
                          },
                        ),
                        const Text(
                          "Campus Sell",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(
                            "Enter your Shop Now",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        const SizedBox(height: 92),
                        emailFormWidget(emailOfFormController),
                        const SizedBox(height: 60),
                        passWrdFormWidget(passwordOfFormController),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              if (emailOfFormController.text.isNotEmpty) {
                                await authController.resetPassword(
                                    emailOfFormController.text.trim());
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'Please enter your email to reset the password',
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 3),
                                );
                              }
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                AuthController authController =
                                    Get.find<AuthController>();
                                try {
                                  await authController.signInWithEmailAndPassword(
                                      emailOfFormController.text.trim(),
                                      passwordOfFormController.text.trim());
                                  if (authController.uid.isNotEmpty) {
                                    Get.to(() =>  NewDashboard());
                                  } else {
                                    Get.snackbar(
                                      'Something went wrong',
                                      'Check your shop credentials or Create a shop if you don\'t have one. Also, ensure you have an active internet connection!',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 6),
                                    );
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                    'Something went wrong',
                                    'Check your Internet connection',
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 3),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text("Don't have a Shop? "),
                            GestureDetector(
                              onTap: () => Get.to(() => Signup()),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  TextFormField passWrdFormWidget(
      TextEditingController passwordOfFormController) {
    return TextFormField(
      controller: passwordOfFormController,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  TextFormField emailFormWidget(TextEditingController emailOfFormController) {
    return TextFormField(
      controller: emailOfFormController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
        labelText: "E-mail",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }
}
