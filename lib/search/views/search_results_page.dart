import 'package:campus_sell/search/controllers/search_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/main_board/clicked_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchedController searchedController = Get.put(SearchedController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${searchedController.searchResults.length} results found" ??
                  "Nothing found"),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: searchedController.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
<<<<<<< HEAD:lib/search/views/search_results_page.dart
                      title: Text(searchedController.searchResults[index]["itemName"].toString()),
                      subtitle: Text(searchedController.searchResults[index]["itemType"].toString()),
                      trailing: Text("Ghs ${searchedController.searchResults[index]["price"]}"),
                      onTap: () => Get.to(()=> const ClickedItem(),arguments: searchedController.searchResults[index]),
=======
                      title: Text(searchedController.searchResults[index]
                              ["itemName"]
                          .toString()),
                      subtitle: Text(searchedController.searchResults[index]
                              ["itemType"]
                          .toString()),
                      trailing: Text(searchedController.searchResults[index]
                              ["price"]
                          .toString()),
                      onTap: () => Get.to(() => const ClickedItem(),
                          arguments: searchedController.searchResults[index]),
>>>>>>> c8065632fe2d20d82a1f3d85121330c51077fbd0:lib/main_board/search_results_page.dart
                      // () => Get.to(const searchedController.searchResults[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    home: SearchResultPage(),
  ));
}
