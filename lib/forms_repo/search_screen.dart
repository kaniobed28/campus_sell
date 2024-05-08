import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/list_sold_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> cityList = [
    "Select City",
    "Accra",
    "Kumasi",
    "Sunyani",
    "Techiman",
    "Kintampo",
    "Tamale",
    "Takoradi",
    "Ho",
    "Cape Coast",
    "Bolgatanga",
    "Wa"
  ];
  List<String> itemypeList = [
    "Select Item Type",
    "Fashion",
    "Food",
    "Electronic",
    "Beauty Products",
    "Sports Equipment",
    "Stationery",
    "Healthcare Products",
    "Jewelry",
    "Kitchen Appliances",
    "Others"
  ];
  List<String> universityList = [
    "Select University",
    "University of Ghana",
    "KNUST",
    "UCC",
    "UEW",
    "UDS",
    "Ashesi University",
    "GIMPA",
    "Central University",
    "UPSA",
    "Valley View University"
  ];

  final _formKey = GlobalKey<FormState>();

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController hostelController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController universityNameController = TextEditingController();

  AuthController authController = Get.find<AuthController>();
  ListSearchItems listSearchItems = Get.find<ListSearchItems>();

  @override
  Widget build(BuildContext context) {
    itemNameController.text = "";
    brandNameController.text = "";
    hostelController.text = "";
    hostelController.text = "";
    itemTypeController.text = "";
    cityNameController.text = "";
    universityNameController.text = "";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Text("Search Here"),
          centerTitle: true,
          actions: const [
            Icon(Icons.search),
          ],
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the _formKey to the Form widget
            child: Container(
              margin:const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                const  SizedBox(height: 30),
                  nameFormWidget(
                    itemNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Item Name",
                    prefixIcon: Icons.sports_basketball,
                  ),
                const  SizedBox(height: 30),
                  nameFormWidget(
                    brandNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Brand Name",
                    prefixIcon: Icons.branding_watermark,
                  ),
                const  SizedBox(height: 30),
                  nameFormWidget(
                    hostelController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Hostel Name",
                    prefixIcon: Icons.location_city,
                  ),
                const  SizedBox(height: 30),
                  DropdownButtonFormField(
                      value: cityList[0],
                      items: cityList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        cityNameController.text = val as String;
                      }),
                 const SizedBox(height: 30),
                  DropdownButtonFormField(
                      value: universityList[0],
                      items: universityList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        universityNameController.text = val as String;
                      }),
                 const SizedBox(height: 30),
                  DropdownButtonFormField(
                    value: itemypeList[0],
                    items: itemypeList
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      itemTypeController.text = val as String;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // _hostelNameController
                          // _universityNameController
                          // _cityNameController
                          // _brandNameController_itemNameController
                          // print(hostelNameController.text);
                          // print(universityNameController.text);
                          // print(itemNameController.text);
                          // print(brandNameController.text);
                          // print(cityNameController.text);
                          // print(itemTypeController.text);
                          // listSearchItems.listFromAddInfo(
                          //     universityNameController.text
                          //         .trim()
                          //         .toLowerCase(),
                          //     cityNameController.text.trim().toLowerCase(),
                          //     brandNameController.text.trim().toLowerCase(),
                          //     hostelController.text.trim().toLowerCase());
                          // listSearchItems.ownerIds.clear();
                          listSearchItems.listSearchItems(
                              itemTypeController.text.trim().toLowerCase(),
                              universityNameController.text
                                  .trim()
                                  .toLowerCase(),
                              cityNameController.text.trim().toLowerCase(),
                              brandNameController.text.trim().toLowerCase(),
                              hostelController.text.trim().toLowerCase());
                        }
                      },
                      icon: const Icon(Icons.search), // Add your desired icon here
                      label: const Text(
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
  IconData?
      prefixIcon, // Accepts an optional IconData parameter for the prefix icon
}) {
  return TextFormField(
    controller: nameOfFormController,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: nameOfLabel,
      border:const OutlineInputBorder(),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon)
          : null, // Use the provided icon if not null
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
