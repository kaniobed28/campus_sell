import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/main_board/dashboard.dart';
import 'package:campus_sell/signup_in/signup.dart';
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
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double widtht_of_screen = MediaQuery.of(context).size.width;
    double height_of_screen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: authController.isAuthenticated.isTrue
          ? DashBoardM()
          : Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: widtht_of_screen,
                    height: height_of_screen,
                    padding: EdgeInsets.all(10),
                    color: Colors.blueGrey[50],
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopify_rounded,
                            size: 80,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            // Add functionality to the IconButton if needed
                          },
                        ),
                        Text(
                          "Campus Sell",
                        ),
                        const SizedBox(height: 128),
                        emailFormWidget(emailOfFormController),
                        const SizedBox(height: 60),
                        passWrdFormWidget(passwordOfFormController),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
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
                                    Get.to(() => DashBoardM());
                                  } else {
                                    // print("wrong"); //do some message to user here
                                    Get.snackbar(
                                      'Somethng went wrong',
                                      'Check your credentials or Internet connection',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(seconds: 3),
                                    );
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                      'Somethng went wrong',
                                      'Check your Internet connection',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(seconds: 3),
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
                            "Don't have an account? ",
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => Signup()),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.amber),
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
