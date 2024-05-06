import 'package:campus_sell/controllers/image_controller.dart';
import 'package:campus_sell/controllers/selling_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/forms_repo/image_picker.dart';
import 'package:campus_sell/main_board/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellPage extends StatelessWidget {
  SellPage({Key? key}) : super(key: key);

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put<ItemForSaleController>(ItemForSaleController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sell'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: itemNameController,
                    decoration: const InputDecoration(
                      labelText: "Product Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: itemTypeController.text.isNotEmpty
                        ? itemTypeController.text
                        : null,
                    items: const [
                      DropdownMenuItem<String>(
                        value: "Select Item Type",
                        child: Text("Select Item Type"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Fashion",
                        child: Text("Fashion"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Food",
                        child: Text("Food"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Electronic",
                        child: Text("Electronic"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Beauty Products",
                        child: Text("Beauty Products"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Sports Equipment",
                        child: Text("Sports Equipment"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Stationery",
                        child: Text("Stationery"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Healthcare Products",
                        child: Text("Healthcare Products"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Jewelry",
                        child: Text("Jewelry"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Kitchen Appliances",
                        child: Text("Kitchen Appliances"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Others",
                        child: Text("Others"),
                      ),
                    ],
                    onChanged: (val) {
                      itemTypeController.text = val!;
                    },
                    decoration: InputDecoration(
                      labelText: "Product Type",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: itemPriceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: "Product Price",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: itemDescriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      labelText: "Product Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  ImagePickerPage(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ImageController imageController =
                            Get.find<ImageController>();
                        ItemForSaleController itemForSaleController =
                            Get.find<ItemForSaleController>();
                        await imageController.uploadImagesToFirebase();
                        itemForSaleController.addItem(
                            itemNameController.text,
                            itemTypeController.text,
                            itemDescriptionController.text,
                            double.parse(itemPriceController.text),
                            imageController.imagesUrls.cast<String>());
                        Get.to(() => DashBoardM());
                      }
                    },
                    child: Text('Upload'),
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

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    home: SellPage(),
  ));
}