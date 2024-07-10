import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/clicked_item/image_controller.dart';
import 'package:campus_sell/controllers/selling_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_image_card.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:campus_sell/reusable_widgets/custom_form_lable.dart';
import 'package:campus_sell/reusable_widgets/custom_forms.dart';
import 'package:campus_sell/reusable_widgets/custom_sell_form_card.dart';
import 'package:campus_sell/web_image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  final WebFilePickerController imageController =
      Get.put(WebFilePickerController());
  final ImageController imageController2 = Get.put(ImageController());

  @override
  void dispose() {
    itemTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    AuthController authController = Get.find<AuthController>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFF2F2F2),
        body: SingleChildScrollView(
          child: Obx(
            ()=> Column(
              children: [
                Center(
                  child: SizedBox(
                    height: screenHeight * 0.35,
                    width: screenWidth * 0.70,
                    child: GestureDetector(
                      onTap: () async{
                        if (kIsWeb) {
                       await imageController.pickFile();
                          
                        } else {
                          await imageController2.pickImage(ImageSource.gallery);
                        }
                      },
                      child: const AgoTechAssetImageCard(
                          imagePath: "assets/img/add-image.jpg"),
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
                            NameForm(
                              nameController: itemNameController,
                            ),
                            const CustomFormLable(
                                textLable: "Product Description*:"),
                            DescriptionForm(
                              nameController: itemDescriptionController,
                            ),
                            const CustomFormLable(textLable: "Product Type*:"),
                            CustomDropdownButtonFormField(
                                itemTypeController: itemTypeController),
                            const CustomFormLable(textLable: "Product Price*:"),
                            PriceForm(
                              nameController: itemPriceController,
                            ),
                            const SizedBox(
                                height:
                                    20), 
                                    Text("${imageController.pickFilesList}"),
                                    // Add spacing between form fields and button
                            ElevatedButton(
                              onPressed: () async {
                                List imagesUrls = [];
                                if (formKey.currentState!.validate()) {
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
                                      itemNameController.text
                                          .trim()
                                          .capitalizeFirst!,
                                      itemTypeController.text
                                          .trim()
                                          .capitalizeFirst!,
                                      itemDescriptionController.text
                                          .trim()
                                          .capitalizeFirst!,
                                      double.parse(itemPriceController.text
                                          .trim()
                                          .capitalizeFirst!),
                                      imagesUrls,
                                      authController.uid.value);
                                  // print(itemTypeController.text);
                                  // print(itemPriceController.text);
                                }
                              },
                              child: const Text("UPLOAD"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(height: 50),
      ),
    );
  }
}
