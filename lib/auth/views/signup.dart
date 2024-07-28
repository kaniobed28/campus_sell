import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signin.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  Signup({super.key})
      : emailOfFormController = TextEditingController(),
        passwordOfFormController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordOfFormController;
  final TextEditingController emailOfFormController;

  // AuthController authController = Get.put(AuthController());

  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: authController.isAuthenticated.isTrue
          ? const NewDashboard()
          : Scaffold(
              body: Form(
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
                          "Create your online Shop Now",
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
                              try {
                                await authController.signUpWithEmailAndPassword(
                                    emailOfFormController.text.trim(),
                                    passwordOfFormController.text.trim());

                                if (authController.uid.value.isNotEmpty) {
                                  // print(authController.uid.isNotEmpty);
                                  AdditionalInfoController
                                      additionalInfoController =
                                      Get.find<AdditionalInfoController>();
                                  await additionalInfoController
                                      .addDataToFirestore(
                                          {}, authController.uid.value);
                                  // authController.dispose();
                                  Get.to(() => const NewDashboard());
                                } else {
                                  Get.snackbar(
                                    'Somethng went wrong',
                                    'Check your Internet connection. Password must be minimum of length 6,',
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 3),
                                  ); //I have to work here
                                }
                              } catch (e) {
                                Get.snackbar(
                                  'Somethng went wrong',
                                  'Check your Internet connection. Password must be minimum of length 6',
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
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        const Text(
                          "Already have a Shop? ",
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => SignIn()),
                          child: const Text(
                            "Sign in",
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

// void main() {
//   runApp(MaterialApp(
//     home: Signup(),
//   ));
// }