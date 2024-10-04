import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For social media icons

class SignIn extends StatefulWidget {
  SignIn({super.key})
      : emailOfFormController = TextEditingController(),
        passwordOfFormController = TextEditingController();

  final TextEditingController passwordOfFormController;
  final TextEditingController emailOfFormController;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  AuthController authController = Get.put(AuthController());

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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: widthOfScreen,
              height: heightOfScreen,
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  // Welcome Text
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Subheading Text
                  RichText(
                    text: const TextSpan(
                      text: 'Sign in to ',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Continue',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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

                  // Divider with text "Or"
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Or"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Email Form Field
                  emailFormWidget(widget.emailOfFormController),

                  const SizedBox(height: 20),

                  // Password Form Field
                  passWrdFormWidget(widget.passwordOfFormController),

                  const SizedBox(height: 10),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await authController.signInWithEmailAndPassword(
                            widget.emailOfFormController.text.trim(),
                            widget.passwordOfFormController.text.trim(),
                          );
                          if (authController.uid.isNotEmpty) {
                            Get.toNamed("/shop");
                          } else {
                            Get.snackbar(
                              'Something went wrong',
                              'Check your credentials or sign up.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 3),
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
                    child:  Text(
                      'Login',
                      style: TextStyle(color:Theme.of(context).colorScheme.onSurface),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.emailOfFormController.text.isNotEmpty) {
                          await authController
                              .resetPassword(widget.emailOfFormController.text.trim());
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
                        "Forgot your password?",
                        style: TextStyle(
                          color: Colors.blue,
                          // decoration: TextDecoration.,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () => Get.to(() => Signup()),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
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
}
