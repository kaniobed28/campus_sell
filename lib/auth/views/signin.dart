import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/auth/views/signup.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key})
      : emailOfFormController = TextEditingController(),
        passwordOfFormController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordOfFormController;
  final TextEditingController emailOfFormController;
   AuthController authController = Get.put(AuthController());
  // AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: authController.isAuthenticated.isTrue
          ? const NewDashboard()
          : Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight,
                    padding: const EdgeInsets.all(10),
                    color: Colors.blueGrey[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        // I have left empty height here
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Add functionality for form submission here
                                // For example, you can access the form data using:
                                // emailOfFormController.text and passwordOfFormController.text
                                AuthController authController =
                                    Get.find<AuthController>();
                                try {
                                  await authController
                                      .signInWithEmailAndPassword(
                                          emailOfFormController.text.trim(),
                                          passwordOfFormController.text.trim());
                                  if (authController.uid.isNotEmpty) {
                                    // authController.dispose();
                                    // print("wrong"); //do some message to user here
                                    Get.to(() => const NewDashboard());
                                  } else {
                                    Get.snackbar(
                                      'Somethng went wrong',
                                      'Check your shop credentials or Create a shop if you dont have else Internet connection!',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 6),
                                    );
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                    'Somethng went wrong',
                                    'Check your Internet connection',
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 3),
                                  );
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => SellInfoScreen()),
                                // );
                              }
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Row(children: [
                          const Text(
                            "Don't have a Shop? ",
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => Signup()),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // Form methods
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

// class SellInfoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sell Info'),
//       ),
//       body: Center(
//         child: Text('Sell Info Screen with some'),
//       ),
//     );
//   }
// }

// class Try extends StatelessWidget {
//   const Try({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  GetMaterialApp(
//       home: SignIn() ,
//     );
//   }
// }

// the main is for trials only
void main() {
  runApp(GetMaterialApp(
    home: SignIn(),
  ));
}
