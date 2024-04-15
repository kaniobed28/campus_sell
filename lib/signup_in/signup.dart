import 'package:flutter/material.dart';

final GlobalKey _formKey = GlobalKey<FormState>();

class Signup extends StatelessWidget {
  const Signup({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
          padding: EdgeInsets.all(10),
          // margin: EdgeInsets.all(20.0),
          key: _formKey,
          color: Colors.blueGrey[50],
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.shopify_rounded),
                onPressed: () {},
              ),
              Text(
                "Campus Sell",
              ),
              const SizedBox(height: 128),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "First Name",
                
                ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}
