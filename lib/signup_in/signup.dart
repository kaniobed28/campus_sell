import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/main_board/dashboard.dart';
import 'package:campus_sell/signup_in/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  Signup({Key? key})
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
      
      child: authController.isAuthenticated.isTrue?DashBoardM(): Scaffold(
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Add functionality for form submission here
                          // For example, you can access the form data using:
                          // emailOfFormController.text and passwordOfFormController.text
                          try {
                          await authController.signUpWithEmailAndPassword(emailOfFormController.text.trim(), passwordOfFormController.text.trim());
                            if (authController.isAuthenticated.isTrue) {
                              // print(authController.uid.isNotEmpty);
                              // print(authController.uid.value);
                              AdditionalInfoController additionalInfoController = Get.find<AdditionalInfoController>();
                              await additionalInfoController.addDataToFirestore({}, authController.uid.value);
                          Get.to(() => DashBoardM());
                              
                            } else {
                              // print("wrong");     //I have to work here
                            }
                          } catch (e) {
                            
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                   Row(
                    children: [ const Text(
                      "Already have an account? ",
                    ),GestureDetector(
                      onTap: ()=>Get.to(()=>SignIn()),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.amber),
                      ),
                    )]
                  ),
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

// void main() {
//   runApp(MaterialApp(
//     home: Signup(),
//   ));
// }