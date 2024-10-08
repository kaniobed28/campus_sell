import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/clicked_item/image_controller.dart';
import 'package:campus_sell/controllers/device_controller.dart';
import 'package:campus_sell/dashboard/data_lists.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/constants.dart';
import 'package:campus_sell/main_board/custom_appbar/views/custom_appbar.dart';
import 'package:campus_sell/viewers/controllers/viewers_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../reusable_widgets/custom_bottom_navbar.dart';
import '../reusable_widgets/custom_form_lable.dart';
import '../reusable_widgets/custom_forms.dart';
import '../reusable_widgets/multi_select_dialog.dart';
import '../controllers/additional_info_controller.dart';
import '../controllers/selling_controller.dart';
import '../dashboard/ago_tech_dashboard.dart';
import '../dashboard/ago_tech_image_card.dart';
import '../web_image_picker.dart';

class AgoTechSellScreen extends StatefulWidget {
  const AgoTechSellScreen({super.key});

  @override
  State<AgoTechSellScreen> createState() => _AgoTechSellScreenState();
}

class _AgoTechSellScreenState extends State<AgoTechSellScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final WebFilePickerController imageController = Get.put(WebFilePickerController());
  final ImageController imageController2 = Get.put(ImageController());
  final DeviceController deviceController = Get.find<DeviceController>();
   AuthController authController = Get.find<AuthController>();
  //  ViewController viewController = Get.find<ViewController>();
  RxInt totalImages = 0.obs;
  RxBool uploading = false.obs;

  List<String> selectedCountries = [];
  List<String> selectedUniversities = [];
  List<String> selectedCities = [];

  bool get isGhanaSelected => selectedCountries.contains("Ghana");

  @override
  void dispose() {
    itemTypeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // AuthController authController = Get.find<AuthController>();
    // if (authController.isAuthenticated.isFalse) {
    //   Get.offNamed("/auth/signin");
    // }

    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerWidget(authController: authController,),
        appBar:  CustomAppBar(elevation: 5,),
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
                              totalImages.value = imageController.pickFilesList.length;
                            } else {
                              await imageController2.pickImage(ImageSource.gallery);
                              totalImages.value = imageController2.images.length;
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
                                const CustomFormLable(textLable: "Product Name*:"),
                                NameForm(nameController: itemNameController),
                                const CustomFormLable(textLable: "Product Description*:"),
                                DescriptionForm(nameController: itemDescriptionController),
                                const CustomFormLable(textLable: "Product Type*:"),
                                CustomDropdownButtonFormField(
                                    itemTypeController: itemTypeController,items: productTypes,),
                                const CustomFormLable(textLable: "Product Price*:"),
                                PriceForm(nameController: itemPriceController),

                                const Visibility(
                                  visible: false,
                                  child: CustomFormLable(textLable: "Select Countries*:")),
                                Visibility(
                                  visible: false,
                                  child: MultiSelectField(
                                    title: "Countries",
                                    selectedItems: selectedCountries,
                                    itemList: countryList,
                                    onSelectionChanged: (List<String> selected) {
                                      setState(() {
                                        selectedCountries = selected;
                                        selectedCities.clear();
                                        if (!isGhanaSelected) {
                                          selectedUniversities.clear();
                                        }
                                      });
                                    },
                                  ),
                                ),

                                const Visibility(
                                  visible: false,
                                  child: CustomFormLable(textLable: "Select Universities*:")),
                                Visibility(
                                  visible: false,
                                  child: MultiSelectField(
                                    title: "Universities",
                                    selectedItems: selectedUniversities,
                                    itemList: isGhanaSelected ? universityList : [],
                                    onSelectionChanged: (List<String> selected) {
                                      setState(() {
                                        selectedUniversities = selected;
                                      });
                                    },
                                    enabled: isGhanaSelected,
                                  ),
                                ),

                                const Visibility(
                                  visible: false,
                                  child: CustomFormLable(textLable: "Select Cities*:")),
                                if (selectedCountries.isNotEmpty)
                                  Visibility(
                                    visible: false,
                                    child: MultiSelectField(
                                      title: "Cities",
                                      selectedItems: selectedCities,
                                      itemList: selectedCountries
                                          .expand((country) => countryCityMapping[country] ?? [])
                                          .toList(),
                                      onSelectionChanged: (List<String> selected) {
                                        setState(() {
                                          selectedCities = selected;
                                        });
                                      },
                                    ),
                                  ),

                                const SizedBox(height: 20),

                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<Color>(
                                      const Color(0xFFFBD300),
                                    ),
                                    foregroundColor: WidgetStateProperty.all<Color>(
                                        Colors.black),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      uploading.value = true;
                                      List imagesUrls = [];
                                      if (kIsWeb) {
                                        await imageController.uploadFile();
                                        imagesUrls = imageController.downloadUrlList;
                                      } else {
                                        await imageController2.uploadImagesToFirebase();
                                        imagesUrls = imageController2.imagesUrls;
                                      }

                                      ItemForSaleController itemForSaleController =
                                          Get.put(ItemForSaleController());
                                      itemForSaleController.addItem(
                                          itemNameController.text.trim().capitalizeFirst!,
                                          itemTypeController.text.trim().capitalizeFirst!,
                                          itemDescriptionController.text.trim().capitalizeFirst!,
                                          double.parse(itemPriceController.text.trim()),
                                          imagesUrls,
                                          authController.uid.value,
                                          selectedCountries+selectedUniversities+selectedCities,
                                          
                                          
                                          );

                                      AdditionalInfoController additionalInfoController =
                                          Get.put(AdditionalInfoController());
                                      additionalInfoController.updateAnItemWithAddInfo(
                                          itemNameController.text.trim().capitalizeFirst!);

                                      // Clear all states after upload
                                      imageController.pickFilesList = [].obs;
                                      imageController.downloadUrlList = [].obs;
                                      imageController.pickFilesNameList = [].obs;
                                      imageController2.imagesUrls = <String>[].obs;
                                      imageController2.images = <XFile>[].obs;
                                      totalImages.value = 0;
                                      uploading.value = false;
                                      Get.to(() =>  NewDashboard())?.then(
                                        (value) {},
                                      );
                                    }
                                  },
                                  child: (uploading.value)
                                      ? const CircularProgressIndicator()
                                      : const Text("UPLOAD"),
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
        bottomNavigationBar: Visibility(
        visible: !deviceController.isWeb.value,
        child: CustomBottomNavBar(height: 50)),
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

class MultiSelectField extends StatelessWidget {
  final String title;
  final List<String> selectedItems;
  final List<dynamic> itemList;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool enabled;

  const MultiSelectField({
    Key? key,
    required this.title,
    required this.selectedItems,
    required this.itemList,
    required this.onSelectionChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () async {
        final List<String>? results = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return MultiSelectDialog(
              items: itemList,
              initialSelectedItems: selectedItems,
            );
          },
        );
        if (results != null) {
          onSelectionChanged(results);
        }
      } : null,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: enabled ? Colors.transparent : Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedItems.isNotEmpty ? selectedItems.join(', ') : "Select $title",
                style: TextStyle(color: enabled ? Colors.black54 : Colors.grey),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
