import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/clicked_item/image_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/controllers/selling_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/ago_tech_image_card.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:campus_sell/reusable_widgets/custom_form_lable.dart';
import 'package:campus_sell/reusable_widgets/custom_forms.dart';
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
  RxInt totalImages = 0.obs;
  RxBool uploading = false.obs;

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
        // backgroundColor: const Color(0xFFF2F2F2),
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
                          //add image camera is here
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
                                    textLable: "Product Name*:"),
                                NameForm(
                                  nameController: itemNameController,
                                ),
                                const CustomFormLable(
                                    textLable: "Product Description*:"),
                                DescriptionForm(
                                  nameController: itemDescriptionController,
                                ),
                                const CustomFormLable(
                                    textLable: "Product Type*:"),
                                CustomDropdownButtonFormField(
                                    itemTypeController: itemTypeController),
                                const CustomFormLable(
                                    textLable: "Product Price*:"),
                                PriceForm(
                                  nameController: itemPriceController,
                                ),
                                const SizedBox(height: 20),
                                // Add spacing between form fields and button

                                //Here is the upload button
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      const Color(0xFFFBD300),
                                    ),
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(Colors
                                            .black), // this is responsible for making the text black
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

                                      ItemForSaleController
                                          itemForSaleController =
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

                                      AdditionalInfoController
                                          additionalInfoController =
                                          Get.put(AdditionalInfoController());

                                      //some list are not used but I am clearing all for safty sake.
                                      // also the items here are supposed to be in the then but I dont know why they dont work when I place them there
                                      additionalInfoController
                                          .updateAnItemWithAddInfo(
                                              itemNameController.text
                                                  .trim()
                                                  .capitalizeFirst!);
                                      imageController.pickFilesList = [].obs;
                                      imageController.downloadUrlList = [].obs;
                                      imageController.pickFilesNameList =
                                          [].obs;
                                      imageController2.imagesUrls =
                                          <String>[].obs;
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
        bottomNavigationBar: const CustomBottomNavBar(height: 60),
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
