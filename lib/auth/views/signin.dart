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
                  const LogoWithBorder(),
                  const SizedBox(height: 20),
                  const WelcomeText(),
                  const SizedBox(height: 20),
                  const SocialMediaRow(),
                  const SizedBox(height: 30),
                  const DividerWithText(),
                  const SizedBox(height: 20),
                  emailFormWidget(widget.emailOfFormController),
                  const SizedBox(height: 20),
                  passWrdFormWidget(widget.passwordOfFormController),
                  const SizedBox(height: 10),
                  LoginButton(
                    formKey: _formKey,
                    authController: authController,
                    emailController: widget.emailOfFormController,
                    passwordController: widget.passwordOfFormController,
                  ),
                  const SizedBox(height: 10),
                  ForgotPasswordLink(
                    emailController: widget.emailOfFormController,
                    authController: authController,
                  ),
                  const SizedBox(height: 20),
                  const SignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField passWrdFormWidget(TextEditingController passwordOfFormController) {
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

class LogoWithBorder extends StatelessWidget {
  const LogoWithBorder({super.key});

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

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Sign in to ',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            children: const <TextSpan>[
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
      ],
    );
  }
}

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.google),
          onPressed: () {},
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.twitter),
          onPressed: () {},
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.linkedin),
          onPressed: () {},
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.github),
          onPressed: () {},
        ),
      ],
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Or"),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.authController,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final AuthController authController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
              emailController.text.trim(),
              passwordController.text.trim(),
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
      child: Text(
        'Login',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({
    super.key,
    required this.emailController,
    required this.authController,
  });

  final TextEditingController emailController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {
          if (emailController.text.isNotEmpty) {
            await authController.resetPassword(emailController.text.trim());
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
          ),
        ),
      ),
    );
  }
}

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
