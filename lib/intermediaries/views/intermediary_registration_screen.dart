// lib/screens/add_intermediary_screen.dart

import 'package:campus_sell/intermediaries/controllers/inmediaries_controller.dart';
import 'package:campus_sell/intermediaries/models/intermediaries_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddIntermediaryScreen extends StatefulWidget {
  @override
  _AddIntermediaryScreenState createState() => _AddIntermediaryScreenState();
}

class _AddIntermediaryScreenState extends State<AddIntermediaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final IntermediaryController _intermediaryController = Get.put(IntermediaryController());

  String _name = '';
  String _email = '';
  String _phone = '';

  Future<void> _addIntermediary() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        String intermediaryId = FirebaseFirestore.instance.collection('intermediaries').doc().id;
        Intermediary newIntermediary = Intermediary(
          intermediaryId: intermediaryId,
          name: _name,
          email: _email,
          phone: _phone,
          createdAt: Timestamp.now(),
        );

        await _intermediaryController.addIntermediary(newIntermediary);
        Get.snackbar('Success', 'Intermediary added successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add intermediary: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Intermediary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addIntermediary,
                child: Text('Add Intermediary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
