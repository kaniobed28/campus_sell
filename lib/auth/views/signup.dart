import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  Signup({super.key})
      : emailOfFormController = TextEditingController(),
        passwordOfFormController = TextEditingController();

  final TextEditingController passwordOfFormController;
  final TextEditingController emailOfFormController;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  AuthController authController = Get.find<AuthController>();

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: widthOfScreen,
              height: heightOfScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Logo at the top using Asset Image with Circle Outline
                  Container(
                    width: 100, // Increase the width and height slightly for the circle
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.yellow[700]!, // Border color
                        width: 3.0, // Border thickness
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img/campus-sell-favicon-color.png', // Replace with your image path
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover, // Ensures the image fits within the circle
                      ),
                    ),
                  ),

                  // Welcome Text
                  const Text(
                    "Welcome To",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // App Name Text
                  const Text(
                    "Campus Sell",//will be changed to marketx later
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.amber,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subheading Text
                   Text(
                    "Your First Market",
                    style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
                  ),

                  const SizedBox(height: 20),

                  // Social Media Icons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.google),
                        onPressed: () {
                          // Handle Google sign-in
                        },
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.twitter),
                        onPressed: () {
                          // Handle Twitter sign-in
                        },
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.linkedin),
                        onPressed: () {
                          // Handle LinkedIn sign-in
                        },
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.github),
                        onPressed: () {
                          // Handle GitHub sign-in
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Email Form Field
                  emailFormWidget(widget.emailOfFormController),

                  const SizedBox(height: 20),

                  // Password Form Field
                  passWrdFormWidget(widget.passwordOfFormController),

                  const SizedBox(height: 30),

                  // Sign Up Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await authController.signUpWithEmailAndPassword(
                            widget.emailOfFormController.text.trim(),
                            widget.passwordOfFormController.text.trim(),
                          );
                          if (authController.uid.value.isNotEmpty) {
                            Get.toNamed("/shop");
                          } else {
                            Get.snackbar(
                              'Error',
                              'Sign up failed. Check your Internet connection.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 3),
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Check your Internet connection.',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                          );
                        }
                      }
                    },
                    child:  Text("Sign Up",style: TextStyle(color:Theme.of(context).colorScheme.onSurface),),
                  ),

                  const SizedBox(height: 10),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Get.to(() => SignIn()),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
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

  // Email Form Widget
  TextFormField emailFormWidget(TextEditingController emailOfFormController) {
    return TextFormField(
      controller: emailOfFormController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
        labelText: "Email",
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

  // Password Form Widget
  TextFormField passWrdFormWidget(
      TextEditingController passwordOfFormController) {
    return TextFormField(
      controller: passwordOfFormController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        labelText: "Password",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
