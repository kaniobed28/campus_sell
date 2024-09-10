import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/main.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellInfoScreen extends StatefulWidget {
  @override
  _SellInfoScreenState createState() => _SellInfoScreenState();
}

class _SellInfoScreenState extends State<SellInfoScreen> {
  AuthController authController = Get.find<AuthController>();
  AdditionalInfoController additionalInfoController =
      Get.find<AdditionalInfoController>();

  RxBool update_info = false.obs;
  RxBool isGhanaSelected = false.obs; // Track if Ghana is selected

  List<String> countryList = [
    "Austria",
    "Belgium",
    "Canada",
    "Denmark",
    "Finland",
    "France",
    "Germany",
    "Ghana",
    "Italy",
    "Kenya",
    "Netherlands",
    "Nigeria",
    "Norway",
    "Portugal",
    "South Africa",
    "Spain",
    "Sweden",
    "Switzerland",
    "UK",
    "USA",
  ];

  List<String> universityList = [
    "AAMUSTED",
    "Ashesi University",
    "Central University",
    "GIMPA",
    "KNUST",
    "UCC",
    "UDS",
    "UEW",
    "University of Ghana",
    "UPSA",
    "Valley View University",
  ];

  Map<String, List<String>> countryCityMapping = {
    "Austria": ["Graz", "Innsbruck", "Linz", "Salzburg", "Vienna"],
    "Belgium": ["Antwerp", "Brussels", "Charleroi", "Ghent", "Liège"],
    "Canada": ["Calgary", "Montreal", "Ottawa", "Toronto", "Vancouver"],
    "Denmark": ["Aalborg", "Aarhus", "Copenhagen", "Esbjerg", "Odense"],
    "Finland": ["Espoo", "Helsinki", "Oulu", "Tampere", "Vantaa"],
    "France": [
      "Bordeaux",
      "Lille",
      "Lyon",
      "Marseille",
      "Nantes",
      "Nice",
      "Paris",
      "Strasbourg",
      "Toulouse"
    ],
    "Germany": [
      "Berlin",
      "Cologne",
      "Düsseldorf",
      "Frankfurt",
      "Hamburg",
      "Munich",
      "Stuttgart"
    ],
    "Ghana": [
      "Accra",
      "Bolgatanga",
      "Cape Coast",
      "Ho",
      "Kintampo",
      "Kumasi",
      "Sunyani",
      "Tamale",
      "Takoradi",
      "Techiman",
      "Wa"
    ],
    "Italy": [
      "Bologna",
      "Florence",
      "Genoa",
      "Milan",
      "Naples",
      "Palermo",
      "Rome",
      "Turin"
    ],
    "Kenya": ["Eldoret", "Kisumu", "Mombasa", "Nairobi", "Nakuru"],
    "Netherlands": ["Amsterdam", "Eindhoven", "Rotterdam", "The Hague", "Utrecht"],
    "Nigeria": [
      "Abuja",
      "Benin City",
      "Enugu",
      "Ibadan",
      "Kaduna",
      "Kano",
      "Lagos",
      "Port Harcourt"
    ],
    "Norway": ["Bergen", "Drammen", "Oslo", "Stavanger", "Trondheim"],
    "Portugal": ["Amadora", "Braga", "Coimbra", "Lisbon", "Porto"],
    "South Africa": [
      "Cape Town",
      "Durban",
      "Johannesburg",
      "Port Elizabeth",
      "Pretoria"
    ],
    "Spain": [
      "Barcelona",
      "Madrid",
      "Málaga",
      "Murcia",
      "Seville",
      "Valencia",
      "Zaragoza"
    ],
    "Sweden": ["Gothenburg", "Malmö", "Stockholm", "Uppsala", "Västerås"],
    "Switzerland": ["Basel", "Bern", "Geneva", "Lausanne", "Zurich"],
    "UK": ["Birmingham", "Leeds", "Liverpool", "London", "Manchester"],
    "USA": ["Chicago", "Houston", "Los Angeles", "New York", "Phoenix"],
  };

  List<String> cityList = ["Select City"]; // Default city list

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _universityNameController =
      TextEditingController();
  final TextEditingController _hostelNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _socialMediaController = TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "User Profile",
            style: GoogleFonts.average(),
          ),
          centerTitle: true,
          backgroundColor:  const Color(0xFFFBD300),
          actions: [
            FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.cameraswitch),
                    onPressed: () {
                      // Handle icon button press
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  nameFormWidget(
                    _brandNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Shop's Name",
                    prefixIcon: Icons.branding_watermark,
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: _countryNameController.text.isNotEmpty
                        ? _countryNameController.text
                        : null,
                    items: countryList.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _countryNameController.text = val!;
                        cityList = countryCityMapping[val] ?? ["Select City"];
                        _cityNameController.text = ""; // Reset city selection

                        // Check if Ghana is selected and update the state
                        if (val == "Ghana") {
                          isGhanaSelected.value = true;
                        } else {
                          isGhanaSelected.value = false;
                          _universityNameController.clear(); // Clear university field if not Ghana
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Country",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.flag),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: _cityNameController.text.isNotEmpty
                        ? _cityNameController.text
                        : null,
                    items: cityList.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(
                          city,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      _cityNameController.text = val!;
                    },
                    decoration: const InputDecoration(
                      labelText: "City Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Obx(() => DropdownButtonFormField<String>(
                    value: _universityNameController.text.isNotEmpty
                        ? _universityNameController.text
                        : null,
                    items: universityList.map((String university) {
                      return DropdownMenuItem<String>(
                        value: university,
                        child: Text(
                          university,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    }).toList(),
                    onChanged: isGhanaSelected.value ? (val) {
                      _universityNameController.text = val!;
                    } : null,
                    decoration: const InputDecoration(
                      labelText: "University Name (Ghana only)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school),
                    ),
                    validator: (value) {
                      return null;
                    },
                    disabledHint: const Text("",overflow: TextOverflow.ellipsis,),
                  )),
                  const SizedBox(height: 30),
                  nameFormWidget(
                    _hostelNameController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Address/Hostel Name",
                    prefixIcon: Icons.house_outlined,
                  ),
                  const SizedBox(height: 30),
                  nameFormWidget(
                    _phoneController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Phone Number",
                    prefixIcon: Icons.call,
                  ),
                  const SizedBox(height: 30),
                  nameFormWidget(
                    _socialMediaController,
                    RegExp(r'^[a-zA-Z]+$'),
                    nameOfLabel: "Social Media (eg.WhatsApp No)",
                    prefixIcon: Icons.message,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Obx(
                      () => ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            update_info.value = true;

                            await additionalInfoController
                                .updateDataInFirestore({
                              "brand": _brandNameController.text
                                  .trim()
                                  .capitalizeFirst,
                              "country": _countryNameController.text
                                  .trim()
                                  .capitalizeFirst,
                              "city": _cityNameController.text
                                  .trim()
                                  .capitalizeFirst,
                              "university":
                                  _universityNameController.text.trim(),
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
                            Get.to(() =>  NewDashboard());
                          }
                        },
                        icon: const Icon(
                          Icons.person_4_rounded,
                          color: Color.fromARGB(255, 56, 54, 54),
                        ),
                        label: update_info.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 56, 54, 54)),
                                strokeWidth: 4.0,
                              )
                            : Text(
                                'Update',
                                style: GoogleFonts.average(
                                    color:
                                        const Color.fromARGB(255, 56, 54, 54)),
                              ),
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
  IconData? prefixIcon,
}) {
  return TextFormField(
    controller: nameOfFormController,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: nameOfLabel,
      border: const OutlineInputBorder(),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    ),
    validator: (value) {
      return null;
    },
  );
}
