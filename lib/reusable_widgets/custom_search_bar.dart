import 'package:campus_sell/search/controllers/search_controller.dart';
import 'package:campus_sell/search/views/search_results_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
   const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
  TextEditingController searchTextEditingController= TextEditingController();
  SearchedController searchedController = Get.put(SearchedController());
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
           const Icon(Icons.search, color: Colors.grey),
           const SizedBox(width: 10.0),
           Expanded(
            child: TextField(
              controller: searchTextEditingController,
              decoration:  const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await searchedController.searchItemsName(searchTextEditingController.text);
              Get.to(() => SearchResultPage());
            },
              child: const Icon(Icons.send, color: Colors.grey)),

              
        ],
      ),
    );
  }
}
