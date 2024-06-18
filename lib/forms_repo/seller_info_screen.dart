import 'package:campus_sell/dashboard/main.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellInfoScreen extends StatelessWidget {
  SellInfoScreen({Key? key}) : super(key: key);

  RxBool update_info = false.obs;

  List<String> searchResults = ["Select", "2", "3"];

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

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();

  final TextEditingController _brandNameController = TextEditingController();

  final TextEditingController _cityNameController = TextEditingController();

  final TextEditingController _universityNameController =
      TextEditingController();

  final TextEditingController _hostelNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _socialMediaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Additional Profile for Sellers",style: GoogleFonts.average(),),
          centerTitle: true,
          // leading: Icon(Icons.person_4_rounded),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the _formKey to the Form widget
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                /*
                Phone, whatsapp,email and other social media  links can be added here but are not required.
                Remembrance note: Implement them.
                */
                children: [
                  SizedBox(height: 30),
                  nameFormWidget(
                    _brandNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Brand Name",
                    prefixIcon: Icons.branding_watermark,
                  ),
                  SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: _cityNameController.text.isNotEmpty
                        ? _cityNameController.text
                        : null,
                    items: cityList.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (val) {
                      _cityNameController.text = val!;
                    },
                    decoration: InputDecoration(
                      labelText: "City Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'This field is required';
                      // }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: _universityNameController.text.isNotEmpty
                        ? _universityNameController.text
                        : null,
                    items: universityList.map((String university) {
                      return DropdownMenuItem<String>(
                        value: university,
                        child: Text(university),
                      );
                    }).toList(),
                    onChanged: (val) {
                      _universityNameController.text = val!;
                    },
                    decoration: InputDecoration(
                      labelText: "University Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school),
                    ),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'This field is required';
                      // }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _hostelNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Address/Hostel Name",
                    prefixIcon: Icons.house_outlined,
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _phoneController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Phone Number",
                    prefixIcon: Icons.call,
                  ),
                  SizedBox(height: 30),
                  nameFormWidget(
                    _socialMediaController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Social Media (eg.WhatsApp No)",
                    prefixIcon: Icons.message,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Obx(
                      ()=> ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.transparent),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            update_info.value = true;
                            AuthController authController =
                                Get.find<AuthController>();
                            AdditionalInfoController additionalInfoController =
                                Get.find<AdditionalInfoController>();
                      
                            await additionalInfoController.updateDataInFirestore({
                              // data for addition info goes in here
                              "brand": _brandNameController.text
                                  .trim()
                                  .capitalizeFirst,
                              "city":
                                  _cityNameController.text.trim().capitalizeFirst,
                              "university": _universityNameController.text.trim(),
                              'hostel': _hostelNameController.text
                                  .trim()
                                  .capitalizeFirst,
                              'phone':
                                  _phoneController.text.trim().capitalizeFirst,
                              'socialMedia': _socialMediaController.text
                                  .trim()
                                  .capitalizeFirst,
                            }, authController.uid.toString());
                            await additionalInfoController.updateWithAddInfo();
                            Get.to(() => DashBoard());
                            // Navigator.push(
                            // context,MaterialPageRoute(builder: (context) => DashBoard()), );
                          }
                        },
                        icon: const Icon(
                            Icons.person_4_rounded,color: Color.fromARGB(255, 56, 54, 54),), // Add your desired icon here
                        label: update_info.value
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 56, 54, 54)),
                                strokeWidth: 4.0,
                              )
                            :  Text(
                                'Update',
                                style: GoogleFonts.average(color:const Color.fromARGB(255, 56, 54, 54)),),
                              
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
      border: OutlineInputBorder(),
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
