
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/selling_controller.dart';
import 'package:campus_sell/dashboard/main.dart';
import 'package:campus_sell/web_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WebFilePickerUI extends StatelessWidget {
  final WebFilePickerController controller = Get.put(WebFilePickerController());
   TextEditingController itemNameController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    RxBool uploading = false.obs;


  @override
  Widget build(BuildContext context) {
  // Get.put(AuthController());

    AuthController authController = Get.find<AuthController>();
    
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(

                padding: const EdgeInsets.all(20.0),
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
                          value: "",
                          child: Text("Select Item Type"),
                        ),
                        DropdownMenuItem<String>(
                          value: "fashion", //I am not changing the value of fashion and food to begin with small because I just used for trial and doing it that was is possible but I must make changes in the code
                          child: Text("Fashion"),
                        ),
                        DropdownMenuItem<String>(
                          value: "food",
                          child: Text("Food"),
                        ),
                        DropdownMenuItem<String>(
                          value: "electronic",
                          child: Text("Electronic"),
                        ),
                        DropdownMenuItem<String>(
                          value: "beauty",
                          child: Text("Beauty Products"),
                        ),
                        DropdownMenuItem<String>(
                          value: "sports",
                          child: Text("Sports Equipment"),
                        ),
                        DropdownMenuItem<String>(
                          value: "stationery",
                          child: Text("Stationery"),
                        ),
                        DropdownMenuItem<String>(
                          value: "healthcare",
                          child: Text("Healthcare Products"),
                        ),
                        DropdownMenuItem<String>(
                          value: "jewelry",
                          child: Text("Jewelry"),
                        ),
                        DropdownMenuItem<String>(
                          value: "kitchen",
                          child: Text("Kitchen Appliances"),
                        ),
                        DropdownMenuItem<String>(
                          value: "others",
                          child: Text("Others"),
                        ),
                      ],
                      onChanged: (val) {
                        itemTypeController.text = val!;
                      },
                      decoration:const InputDecoration(
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
                    //  ImagePickerPage(),
                   
                  ],
                ),
              ),
            ),
          ),



            Obx(() => controller.pickedFile.value != null
                ? Text('Picked file: ${controller.pickedFile.value!.name}')
                : const Text('No file picked')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){controller.pickFile();},
              child: const Text('Select an Image'),
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isUploading.value
                ? Column(
                    children: [
                      LinearProgressIndicator(value: controller.uploadProgress.value / 100),
                      const SizedBox(height: 10),
                      Text('${controller.uploadProgress.value.toStringAsFixed(2)}% uploaded'),
                    ],
                  )
                : Container()),
            
            const SizedBox(height: 20),
           
                 Obx(
                      ()=> ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // uploading.value = true;
                            WebFilePickerController webFilePickerController =
                                Get.put(WebFilePickerController());
                            ItemForSaleController itemForSaleController =
                                Get.put(ItemForSaleController());
                            await webFilePickerController.uploadFile();
                            itemForSaleController.addItem(
                                itemNameController.text.trim().capitalizeFirst!,
                                itemTypeController.text.trim().capitalizeFirst!,
                                itemDescriptionController.text.trim().capitalizeFirst!,
                                double.parse(itemPriceController.text.trim().capitalizeFirst!),
                                <String>[webFilePickerController.downloadUrl.value],
                                authController.uid.value);
                            Get.to(() => DashBoard())?.then((value) {
                              uploading.value = false;
                            },);
                          }
                        },
                        child: uploading.value? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 4.0,
                            ):  Text("upload to Store",style: GoogleFonts.aclonica(color: Colors.black),),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
