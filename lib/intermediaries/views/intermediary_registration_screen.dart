// screens/intermediary_registration_screen.dart

import 'package:campus_sell/intermediaries/controllers/inmediaries_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntermediaryRegistrationScreen extends StatefulWidget {
  const IntermediaryRegistrationScreen({Key? key}) : super(key: key);

  @override
  _IntermediaryRegistrationScreenState createState() => _IntermediaryRegistrationScreenState();
}

class _IntermediaryRegistrationScreenState extends State<IntermediaryRegistrationScreen> {
  final IntermediaryController _intermediaryController = Get.find<IntermediaryController>();
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Intermediary'),
        backgroundColor: const Color(0xFFFBD300),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _name = value!.trim(),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 20),
              // Email Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _email = value!.trim(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter an email';
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Phone Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _phone = value!.trim(),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a phone number' : null,
              ),
              const SizedBox(height: 30),
              // Submit Button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Register'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color(0xFFFBD300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      setState(() {
        _isSubmitting = true;
      });
      await _intermediaryController.registerIntermediary(_name, _email, _phone);
      setState(() {
        _isSubmitting = false;
      });
      // Optionally, navigate back or clear the form
      form.reset();
    }
  }
}
