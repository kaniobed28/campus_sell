import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/delete_controller.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteController deleteController = Get.put(DeleteController());
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' your Items',
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: deleteController.listForDelete(authController.uid.value),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                String id = snapshot.data!.docs[index].id;
                return ListTile(
                  title: Text(
                    data["itemName"],
                    style: GoogleFonts.average(color: Colors.black),
                  ),
                  subtitle: Text(
                    "GH¢ ${data["price"].toString()}",
                    style: GoogleFonts.average(color: Colors.black),
                  ),
                  trailing: FittedBox(
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: "https://campussell.github.io/#/$id"));
                            Get.snackbar("Copied to Cliipboard",
                               "https://campussell.github.io/#/$id" ,
                                duration: const Duration(
                                    seconds: 1, milliseconds: 500));
                          },
                        ),
                        Text(
                          "Copy Url",
                          style: GoogleFonts.average(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 255, 255)),
      home: const SafeArea(
        child: ListScreen(),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  // Get.put(SearchedController());
  Get.put(AdditionalInfoController());
  runApp(MainApp());
}
