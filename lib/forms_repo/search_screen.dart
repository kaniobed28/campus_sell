import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> searchResults = ["Select", "2", "3"];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _universityNameController =
      TextEditingController();
  final TextEditingController _hostelNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Here"),
          centerTitle: true,
          leading: Icon(Icons.search),
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the _formKey to the Form widget
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  nameFormWidget(
                    _itemNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Item Name",
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _brandNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Brand Name",
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _cityNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "City Name",
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _universityNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "University Name",
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _hostelNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Hostel Name",
                  ),
                  SizedBox(height: 30),
                  DropdownButtonFormField(
                      items: searchResults
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {}),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String username = _itemNameController.text;
                          print('Signing up with Username: $username');
                        }
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextFormField nameFormWidget(
  TextEditingController nameOfFormController,
  RegExp regExp, {
  bool obscureText = false,
  String nameOfLabel = '',
}) {
  return TextFormField(
    controller: nameOfFormController,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: nameOfLabel,
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      // if (value == null || value.isEmpty) {
      //   return 'Please enter your $nameOfLabel';
      // }
      // if (!regExp.hasMatch(value)) {
      //   return 'Invalid $nameOfLabel';
      // }
      return null;
    },
  );
}
