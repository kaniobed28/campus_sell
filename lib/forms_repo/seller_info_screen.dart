import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/countryCityUniversitiesMapping.dart';
import 'package:campus_sell/main_board/custom_appbar/views/custom_appbar.dart';
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
  final AdditionalInfoController _additionalInfoController = Get.find<AdditionalInfoController>();

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
      _authController.checkAuthentication(context);
      await _populateFormWithData();
    });
  }

  Future<void> _populateFormWithData() async {
    final existingData = await _additionalInfoController.getDocumentById(_authController.uid.string);
    if (existingData != null) {
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
          _universityList = countryCityUniversitiesMapping["Ghana"]?['universities'] ?? [];
        } else {
          _isGhanaSelected.value = false;
          _universityList = [];
        }

        _cityList = countryCityUniversitiesMapping[_countryNameController.text]?['cities'] ?? ["Select City"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer:  DrawerWidget(authController: _authController,),
        appBar:  CustomAppBar(appBarTitle: "My Profile",elevation: 5,),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildTextField(_brandNameController, "Shop's Name", Icons.branding_watermark),
                  const SizedBox(height: 20),
                  _buildCountryDropdown(),
                  const SizedBox(height: 20),
                  _buildCityDropdown(),
                  const SizedBox(height: 20),
                  Obx(() => _buildUniversityDropdown()),
                  const SizedBox(height: 20),
                  _buildTextField(_hostelNameController, "Address/Hostel Name", Icons.house_outlined),
                  const SizedBox(height: 20),
                  _buildTextField(_phoneController, "Phone Number", Icons.call, inputType: TextInputType.phone),
                  const SizedBox(height: 20),
                  _buildTextField(_socialMediaController, "Social Media (e.g. WhatsApp No)", Icons.message),
                  const SizedBox(height: 30),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color:Theme.of(context).colorScheme.onSurface)),
      ),
      keyboardType: inputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildCountryDropdown() {
    return DropdownButtonFormField<String>(
      value: _countryNameController.text.isNotEmpty ? _countryNameController.text : null,
      decoration: InputDecoration(
        labelText: "Select Country",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      items: countryList.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _countryNameController.text = val!;
          _cityList = countryCityUniversitiesMapping[val]?['cities'] ?? ["Select City"];
          _cityNameController.clear();
          if (val == "Ghana") {
            _isGhanaSelected.value = true;
            _universityList = countryCityUniversitiesMapping["Ghana"]?['universities'] ?? [];
          } else {
            _isGhanaSelected.value = false;
            _universityList = [];
            _universityNameController.clear();
          }
        });
      },
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: _cityNameController.text.isNotEmpty ? _cityNameController.text : null,
      decoration: InputDecoration(
        labelText: "Select City",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      items: _cityList.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _cityNameController.text = val!;
        });
      },
    );
  }

  Widget _buildUniversityDropdown() {
    return DropdownButtonFormField<String>(
      value: _universityNameController.text.isNotEmpty ? _universityNameController.text : null,
      decoration: InputDecoration(
        labelText: "Select University",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      items: _universityList.map((String university) {
        return DropdownMenuItem<String>(
          value: university,
          child: Text(university),
        );
      }).toList(),
      onChanged: _isGhanaSelected.value ? (val) {
        setState(() {
          _universityNameController.text = val!;
        });
      } : null, // Disable onChanged if not in Ghana
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _updateInfo.value = true;

          await _additionalInfoController.updateDataInFirestore({
            "brand": _brandNameController.text.trim().capitalizeFirst,
            "country": _countryNameController.text.trim().capitalizeFirst,
            "city": _cityNameController.text.trim().capitalizeFirst,
            "university": _universityNameController.text.trim(),
            'hostel': _hostelNameController.text.trim().capitalizeFirst,
            'phone': _phoneController.text.trim(),
            'socialMedia': _socialMediaController.text.trim(),
          }, _authController.uid.toString());

          await _additionalInfoController.updateWithAddInfo();
          Get.to(() => NewDashboard());
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Obx(() {
        return _updateInfo.value
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Text("Submit", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onSurface));
      }),
    );
  }
}
