import 'package:campus_sell/controllers/image_controller.dart';
import 'package:campus_sell/controllers/selling_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/forms_repo/image_picker.dart';
import 'package:campus_sell/main_board/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellPage extends StatelessWidget {
  SellPage({super.key});
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
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: itemTypeController,
                    decoration: const InputDecoration(
                        labelText: "Product Type",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller:
                        itemPriceController, // make sure that it accepts double as price not string.
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: "Product Price",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: itemDescriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        labelText: "Product Description",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  ImagePickerPage(),
                  ElevatedButton(
                    
                    onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      
                      ImageController imageController =
                          Get.find<ImageController>();
                      ItemForSaleController itemForSaleController =
                          Get.find<ItemForSaleController>();
                     await imageController
                          .uploadImagesToFirebase(); //upload  the images to firebase storage and get the download url
                      imageController.imagesUrls.toList();//converting the list to list  of strings and storing them for firestore.
                      itemForSaleController.addItem(
                          itemNameController.text,
                          itemTypeController.text,
                          itemDescriptionController.text,
                          double.parse(itemPriceController.text),
                           imageController.imagesUrls.cast());
                      Get.to(() => DashBoard());
                    }
                    } , 
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

// void main(List<String> args) async{
  
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const GetMaterialApp(
//     home: SellPage(),
//   ));
// }