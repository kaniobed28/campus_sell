import 'package:campus_sell/search/controllers/search_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/clicked_item/clicked_item.dart';
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
                      title: Text(searchedController.searchResults[index]["itemName"].toString()),
                      subtitle: Text(searchedController.searchResults[index]["itemType"].toString()),
                      trailing: Text("Ghs ${searchedController.searchResults[index]["price"]}"),
                      onTap: () => Get.to(()=> const ClickedItem(),arguments: searchedController.searchResults[index]),
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
