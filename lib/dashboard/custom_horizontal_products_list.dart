import 'package:campus_sell/dashboard/category_all_product_page.dart';
import 'package:campus_sell/reusable_widgets/custom_category_lable.dart';
import 'package:campus_sell/reusable_widgets/custom_small_product_card.dart';
import 'package:campus_sell/viewers/controllers/viewers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Import the package
import 'package:get/get.dart';

class CustomHorizontalProductsList extends StatelessWidget {
  final RxList<Map<String, dynamic>> lists;
  final String categoryLabel;

  const CustomHorizontalProductsList({
    super.key,
    required this.categoryLabel,
    required this.lists,
  });

  @override
  Widget build(BuildContext context) {
    ViewController viewController = Get.find<ViewController>();
    return Obx(
      () => Visibility(
        visible: lists.isNotEmpty, // Show only if the list is not empty
        child: Column(
          children: [
            Slidable(
              key: ValueKey(categoryLabel),
              startActionPane: ActionPane(
                motion: const ScrollMotion(), // Slideable motion type
                children: [
                  SlidableAction(
                    
                    onPressed: (context) {
                      // Trigger action when sliding
                       Get.to(
                        duration: const Duration(milliseconds: 500),
                        transition:Transition.downToUp,
                        CategoryAllProductsPage(
                        productList: lists,
                        categoryLabel: categoryLabel,
                        
                      ));
                    },
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    icon: Icons.arrow_drop_down,
                    label: 'See All',
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCategoryLabel(
                      textLabel: categoryLabel,
                      backgroundColor: Colors.teal, // Custom color
                      textColor: Colors.white,
                      padding: 12.0,
                      borderRadius: 16.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to a new page showing all items in the category
                      Get.to(
                        duration: const Duration(milliseconds: 500),
                        transition:Transition.cupertino,
                        CategoryAllProductsPage(
                        productList: lists,
                        categoryLabel: categoryLabel,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 225, // Card size
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
                          await Get.toNamed("/shopitems/itemcode/${data['id']}");
                          await viewController.markItemAsViewedByUser(data['id']);
                          await viewController.markItemAsViewed(data['id'], data['ownerId']);
                        } else {
                          // Handle the case when 'id' is null
                        }
                      },
                      child: SmallProductCard(
                        imageUrl: data["imagesUrls"][0],
                        title: data["itemName"].toString().trim(),
                        price: 'Gh¢${data["price"].toString().trim()}',
                        totalLikes: data["likes"].length.toString(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
