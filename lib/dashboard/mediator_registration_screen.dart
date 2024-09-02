import 'package:campus_sell/clicked_item/image_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/ago_tech_image_card.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:campus_sell/web_image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterMediatorScreen extends StatefulWidget {
  const RegisterMediatorScreen({super.key});

  @override
  State<RegisterMediatorScreen> createState() => _RegisterMediatorScreenState();
}

class _RegisterMediatorScreenState extends State<RegisterMediatorScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController contactDetailsController = TextEditingController();
  TextEditingController placesOfServiceController = TextEditingController();
  TextEditingController chosenServiceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final WebFilePickerController imageController =
      Get.put(WebFilePickerController());
  final ImageController imageController2 = Get.put(ImageController());
  RxInt totalImages = 0.obs;
  RxBool uploading = false.obs;

  @override
  void dispose() {
    companyNameController.dispose();
    companyDescriptionController.dispose();
    contactDetailsController.dispose();
    placesOfServiceController.dispose();
    chosenServiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Obx(
            () => Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: TotalImagesLable(totalImages: totalImages.value),
                ),
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.70,
                        child: GestureDetector(
                          onTap: () async {
                            if (kIsWeb) {
                              await imageController.pickFile();
                              totalImages.value =
                                  imageController.pickFilesList.length;
                            } else {
                              await imageController2
                                  .pickImage(ImageSource.gallery);
                              totalImages.value =
                                  imageController2.images.length;
                            }
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 10,
                                child: AgoTechAssetImageCard(
                                    imagePath: "assets/img/add-image-w.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            color: const Color(0xFFFFFFFF),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const CustomFormLable(
                                    textLable: "Company Name*:"),
                                NameForm(
                                  nameController: companyNameController,
                                ),
                                const CustomFormLable(
                                    textLable: "Company Description*:"),
                                DescriptionForm(
                                  nameController: companyDescriptionController,
                                ),
                                const CustomFormLable(
                                    textLable: "Chosen Service*:"),
                                CustomDropdownButtonFormField(
                                    itemTypeController:
                                        chosenServiceController),
                                const CustomFormLable(
                                    textLable: "Contact Details*:"),
                                ContactForm(
                                  nameController: contactDetailsController,
                                ),
                                const CustomFormLable(
                                    textLable: "Places of Service*:"),
                                PlacesForm(
                                  placesController: placesOfServiceController,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      const Color(0xFFFBD300),
                                    ),
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(
                                      Colors.black,
                                    ),
                                  ),
                                  onPressed: () async {
                                    List imagesUrls = [];
                                    if (formKey.currentState!.validate()) {
                                      uploading.value = true;
                                      if (kIsWeb) {
                                        await imageController.uploadFile();
                                        imagesUrls =
                                            imageController.downloadUrlList;
                                      } else {
                                        await imageController2
                                            .uploadImagesToFirebase();
                                        imagesUrls =
                                            imageController2.imagesUrls;
                                      }

                                      // Add your registration logic here

                                      // Clear the forms and reset states
                                      companyNameController.clear();
                                      companyDescriptionController.clear();
                                      contactDetailsController.clear();
                                      placesOfServiceController.clear();
                                      chosenServiceController.clear();
                                      imageController.pickFilesList = [].obs;
                                      imageController.downloadUrlList = [].obs;
                                      imageController.pickFilesNameList = [].obs;
                                      imageController2.imagesUrls = <String>[].obs;
                                      imageController2.images = <XFile>[].obs;
                                      totalImages.value = 0;
                                      uploading.value = false;
                                      Get.to(() => const NewDashboard())?.then(
                                        (value) {},
                                      );
                                    }
                                  },
                                  child: (uploading.value)
                                      ? const CircularProgressIndicator()
                                      : const Text("REGISTER"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(height: 50),
      ),
    );
  }
}

class TotalImagesLable extends StatelessWidget {
  const TotalImagesLable({
    super.key,
    required this.totalImages,
  });

  final int totalImages;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "$totalImages",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        const Text("Selected"),
      ],
    );
  }
}

class PlacesForm extends StatefulWidget {
  final TextEditingController placesController;

  const PlacesForm({super.key, required this.placesController});

  @override
  _PlacesFormState createState() => _PlacesFormState();
}

class _PlacesFormState extends State<PlacesForm> {
  final List<String> _places = ['City A', 'City B', 'City C', 'City D', 'City E'];
  final List<String> _selectedPlaces = [];

  @override
  void initState() {
    super.initState();
    if (widget.placesController.text.isNotEmpty) {
      _selectedPlaces.addAll(widget.placesController.text.split(', '));
    }
  }

  void _showMultiSelectDialog(BuildContext context) async {
    final List<String>? selectedValues = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: _places,
          initialSelectedValues: _selectedPlaces,
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        _selectedPlaces.clear();
        _selectedPlaces.addAll(selectedValues);
        widget.placesController.text = _selectedPlaces.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMultiSelectDialog(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.placesController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            labelText: 'Select Places of Service',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select at least one place of service';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedValues;

  const MultiSelectDialog({
    Key? key,
    required this.items,
    required this.initialSelectedValues,
  }) : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  final List<String> _tempSelectedValues = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedValues.addAll(widget.initialSelectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Places of Service'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _tempSelectedValues.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked!) {
                    _tempSelectedValues.add(item);
                  } else {
                    _tempSelectedValues.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_tempSelectedValues);
          },
        ),
      ],
    );
  }
}

class ContactForm extends StatelessWidget {
  final TextEditingController nameController;

  const ContactForm({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: 'Enter Contact Details',
      ),
      maxLines: 2, // Optional: Adjust based on the expected input length
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter contact details';
        }
        return null;
      },
    );
  }
}

class CustomFormLable extends StatelessWidget {
  final String textLable;

  const CustomFormLable({super.key, required this.textLable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Text(
        textLable,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class NameForm extends StatelessWidget {
  final TextEditingController nameController;

  const NameForm({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: 'Enter Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }
}

class DescriptionForm extends StatelessWidget {
  final TextEditingController nameController;

  const DescriptionForm({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        labelText: 'Enter Description',
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final TextEditingController itemTypeController;

  const CustomDropdownButtonFormField(
      {super.key, required this.itemTypeController});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: itemTypeController.text.isNotEmpty ? itemTypeController.text : null,
      items: const [
        DropdownMenuItem(
          value: 'Service A',
          child: Text('Service A'),
        ),
        DropdownMenuItem(
          value: 'Service B',
          child: Text('Service B'),
        ),
      ],
      onChanged: (value) {
        itemTypeController.text = value ?? '';
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please choose a service';
        }
        return null;
      },
    );
  }
}
