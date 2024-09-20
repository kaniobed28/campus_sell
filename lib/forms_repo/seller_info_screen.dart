import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/reusable_widgets/countryCityUniversitiesMapping.dart';
import 'package:campus_sell/reusable_widgets/form_for_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellInfoScreen extends StatefulWidget {
  @override
  _SellInfoScreenState createState() => _SellInfoScreenState();
}

class _SellInfoScreenState extends State<SellInfoScreen> {
  // Controllers
  final AuthController _authController = Get.find<AuthController>();
  final AdditionalInfoController _additionalInfoController =
      Get.find<AdditionalInfoController>();

  // State variables
  final RxBool _updateInfo = false.obs;
  final RxBool _isGhanaSelected = false.obs;
  List<String> _cityList = ["Select City"];
  List<String> _universityList = [];

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _brandNameController = TextEditingController();
  final _cityNameController = TextEditingController();
  final _universityNameController = TextEditingController();
  final _hostelNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _socialMediaController = TextEditingController();
  final _countryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch and prepopulate data
      _authController.checkAuthentication();
      await _populateFormWithData();
    });
  }

  Future<void> _populateFormWithData() async {
    // Fetching the existing data from Firestore
    final existingData = await _additionalInfoController
        .getDocumentById(_authController.uid.string);

    if (existingData != null) {
      // Prepopulate the form fields with the fetched data
      setState(() {
        _brandNameController.text = existingData['brand'] ?? '';
        _countryNameController.text = existingData['country'] ?? '';
        _cityNameController.text = existingData['city'] ?? '';
        _universityNameController.text = existingData['university'] ?? '';
        _hostelNameController.text = existingData['hostel'] ?? '';
        _phoneController.text = existingData['phone'] ?? '';
        _socialMediaController.text = existingData['socialMedia'] ?? '';

        if (_countryNameController.text == "Ghana") {
          _isGhanaSelected.value = true;
          _universityList =
              countryCityUniversitiesMapping["Ghana"]?['universities'] ?? [];
        } else {
          _isGhanaSelected.value = false;
          _universityList = [];
        }

        _cityList = countryCityUniversitiesMapping[_countryNameController.text]
                ?['cities'] ??
            ["Select City"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Profile", style: GoogleFonts.average()),
          centerTitle: true,
          backgroundColor: const Color(0xFFFBD300),
          actions: [
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: () {
                // Handle icon button press
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildTextField(_brandNameController,
                      "Shop's Name", Icons.branding_watermark, r'.*'),
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildCountryDropdown(
                      context, _countryNameController, countryList, (val) {
                    setState(() {
                      _countryNameController.text = val!;
                      _cityList = countryCityUniversitiesMapping[val]
                              ?['cities'] ??
                          ["Select City"];
                      _cityNameController.clear();
                      if (val == "Ghana") {
                        _isGhanaSelected.value = true;
                        _universityList =
                            countryCityUniversitiesMapping["Ghana"]
                                    ?['universities'] ??
                                [];
                      } else {
                        _isGhanaSelected.value = false;
                        _universityList = [];
                        _universityNameController.clear();
                      }
                    });
                  }),
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildCityDropdown(
                      context, _cityNameController, _cityList, (val) {
                    setState(() {
                      _cityNameController.text = val!;
                    });
                  }),
                  const SizedBox(height: 30),
                  Obx(() => SellInfoWidgets.buildUniversityDropdown(
                      context,
                      _universityNameController,
                      _universityList,
                      _isGhanaSelected.value)),
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildTextField(_hostelNameController,
                      "Address/Hostel Name", Icons.house_outlined, r'.*'),
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildTextField(_phoneController,
                      "Phone Number", Icons.call, r'^[0-9]+$'),
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildTextField(_socialMediaController,
                      "Social Media (e.g. WhatsApp No)", Icons.message, r'.*'),
                  const SizedBox(height: 30),
                  SellInfoWidgets.buildSubmitButton(_updateInfo, () async {
                    if (_formKey.currentState!.validate()) {
                      _updateInfo.value = true;

                      await _additionalInfoController.updateDataInFirestore({
                        "brand":
                            _brandNameController.text.trim().capitalizeFirst,
                        "country":
                            _countryNameController.text.trim().capitalizeFirst,
                        "city": _cityNameController.text.trim().capitalizeFirst,
                        "university": _universityNameController.text.trim(),
                        'hostel':
                            _hostelNameController.text.trim().capitalizeFirst,
                        'phone': _phoneController.text.trim(),
                        'socialMedia': _socialMediaController.text.trim(),
                      }, _authController.uid.toString());

                      await _additionalInfoController.updateWithAddInfo();
                      Get.to(() => NewDashboard());
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
