import 'package:campus_sell/dashboard/ago_tech_clicked_item.dart';
import 'package:campus_sell/search/controllers/search_controller.dart';
import 'package:campus_sell/firebase_options.dart';
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
        // backgroundColor: const Color(0xFFF2F2F2 ),
        appBar: AppBar(
          title: Text(
              "${searchedController.searchResults.length} results found"),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: searchedController.searchResults.length,
                  itemBuilder: (context, index) {
                    final data = searchedController.searchResults[index];
                    return ListTile(
                      title: Text(searchedController.searchResults[index]["itemName"].toString()),
                      subtitle: Text(searchedController.searchResults[index]["itemType"].toString()),
                      trailing: Text("\$ ${searchedController.searchResults[index]["price"]}"),
                      onTap: () => Get.toNamed("/shopitems/itemcode/${data['id']}")
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
