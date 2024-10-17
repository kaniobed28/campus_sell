import 'package:campus_sell/search/controllers/search_controller.dart';
import 'package:campus_sell/search/views/search_results_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController searchTextEditingController = TextEditingController();
  SearchedController searchedController = Get.put(SearchedController());

  @override
  void initState() {
    super.initState();
    searchTextEditingController.addListener(() {
      setState(() {}); // Trigger a rebuild when text changes
    });
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 25.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: searchTextEditingController,
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  await searchedController.searchItemsName(value);
                  Get.to(() => SearchResultPage());
                }
              },
              style: const TextStyle(
                color: Colors.black
              ),
              decoration: const InputDecoration(
                hintText: 'Search items...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          if (searchTextEditingController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                searchTextEditingController.clear();
              },
            ),
          GestureDetector(
            onTap: () async {
              if (searchTextEditingController.text.isNotEmpty) {
                await searchedController.searchItemsName(searchTextEditingController.text);
                Get.to(() => SearchResultPage());
              }
            },
            child: const Icon(Icons.send, color: Colors.grey, size: 25.0),
          ),
        ],
      ),
    );
  }
}

class SearchBarController extends GetxController {
  RxBool searchBarVisibility = true.obs;

  void toggleSearchBarVisibility() {
    searchBarVisibility.value = !searchBarVisibility.value;
  }
}
