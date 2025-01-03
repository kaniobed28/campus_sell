import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
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
  AdditionalInfoController additionalInfoController = Get.find<AdditionalInfoController>();

  // Toggles password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Handles sign up with email and password
  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authController.signUpWithEmailAndPassword(
          widget.emailOfFormController.text.trim(),
          widget.passwordOfFormController.text.trim(),
        );
        additionalInfoController.addDataToFirestore(
            {"ownerId": authController.uid.value}, authController.uid.value);

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
                  const LogoWithCircleOutline(), // Separated Logo Widget
                  const WelcomeText(), // Separated Welcome Text Widget
                  const SizedBox(height: 20),
                  const SubheadingText(), // Separated Subheading Text Widget
                  const SizedBox(height: 20),
                  const SocialMediaIcons(), // Separated Social Media Icons Widget
                  const SizedBox(height: 30),
                  EmailFormField(controller: widget.emailOfFormController), // Separated Email Field
                  const SizedBox(height: 20),
                  PasswordFormField(
                    controller: widget.passwordOfFormController,
                    obscureText: _obscureText,
                    toggleVisibility: _togglePasswordVisibility,
                  ), // Separated Password Field
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: _handleSignUp,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SignInRedirectText(), // Separated Sign In Redirect
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for the logo with a circle outline
class LogoWithCircleOutline extends StatelessWidget {
  const LogoWithCircleOutline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.yellow[700]!,
          width: 3.0,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/img/campus-sell-favicon-color.png',
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Widget for the welcome text
class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Welcome To",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "Campus Sell",
          style: TextStyle(
            fontSize: 32,
            color: Colors.amber,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

// Widget for the subheading text
class SubheadingText extends StatelessWidget {
  const SubheadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your First Market",
      style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
    );
  }
}

// Widget for social media icons row
class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

// Widget for the email form field
class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  const EmailFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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

// Widget for the password form field
class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback toggleVisibility;

  const PasswordFormField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        labelText: "Password",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
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

// Widget for the sign-in redirect text
class SignInRedirectText extends StatelessWidget {
  const SignInRedirectText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
