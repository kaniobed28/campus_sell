import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<AppForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          nameFormWidget( _usernameController,RegExp(r'^[a-zA-Z]+$'),obscureText: false,nameOfLabel: "password"),
          emailFormWidget(_emailController),
          passWrdFormWidget(_passwordController),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process signup
                  String username = _usernameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // You can handle signup logic here
                  // print('Signing up with Username: $username, Email: $email, Password: $password');
                }
              },
              child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField nameFormWidget( TextEditingController nameOfFormController,RegExp regExp, {bool obscureText=false,String nameOfLabel='',}) {
    
    return TextFormField(
          controller: nameOfFormController,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: nameOfLabel,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $nameOfLabel';
            }
            if (!regExp.hasMatch(value)) {
             return 'Invalid $value';
            }
            return null;
          },
        );
  }

  TextFormField passWrdFormWidget(TextEditingController passwordOfFormController) {
    return TextFormField(
          controller: passwordOfFormController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
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
          decoration: InputDecoration(
            labelText: 'Email',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}