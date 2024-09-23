import 'package:campus_sell/dashboard/category_all_product_page.dart';
import 'package:campus_sell/reusable_widgets/custom_category_lable.dart';
import 'package:campus_sell/reusable_widgets/custom_small_product_card.dart';
import 'package:campus_sell/viewers/controllers/viewers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHorizontalProductsList extends StatelessWidget {
  final RxList<Map<String, dynamic>> lists;
  final String categoryLabel;

  const CustomHorizontalProductsList(
      {super.key, required this.categoryLabel, required this.lists,});

  @override
  Widget build(BuildContext context) {
    ViewController viewController = Get.find<ViewController>();
    return Obx(
      () => Visibility(
        visible: lists.isNotEmpty, // Show only if the list is not empty
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCategoryLable(textLable: categoryLabel),
                GestureDetector(
                  onTap: () {
                    // Navigate to a new page showing all items in the category
                    Get.to(CategoryAllProductsPage(productList: lists, categoryLabel: categoryLabel));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 225, // Keep the card size as per your requirement
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  final data = lists[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (data['id'] != null) {
                          await viewController.markItemAsViewedByUser(data['id']);
                          await viewController.markItemAsViewed(data['id'], data['ownerId']);
                          await Get.toNamed("/shopitems/itemcode/${data['id']}");
                        } else {
                          // Handle the case when 'id' is null
                        }
                      },
                      child: SmallProductCard(
                        imageUrl: data["imagesUrls"][0],
                        title: data["itemName"].toString().trim(),
                        price: '\$${data["price"].toString().trim()}',
                        totalLikes: data["likes"].length.toString(),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
