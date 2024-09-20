import 'package:campus_sell/reusable_widgets/custom_category_lable.dart';
import 'package:campus_sell/reusable_widgets/custom_small_product_card.dart';
import 'package:campus_sell/viewers/controllers/viewers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHorizontalProductsList extends StatelessWidget {
  final RxList<Map<String, dynamic>> lists;
  final String categoryLable;
  
  const CustomHorizontalProductsList(
      {super.key, required this.lists, required this.categoryLable});

  @override
  Widget build(BuildContext context) {
    ViewController viewController = Get.find<ViewController>();
    return Obx(
      //because the column was not observable it was not able to get the data because I think by the time the data base is quering the thing it
      //the widget has already initialized.
      () => Visibility(
        visible: lists.isNotEmpty, //I am checking if the list of the product is not empty then I will show it
        child: Column(
          children: [
            CustomCategoryLable(textLable: categoryLable),
            SizedBox(
              height:
                  225, //I managed the sizes of the cards here and I think it can be changed but 225 makes it not overflow as at now.
              child: ListView.builder(
                //the idea behind this builder is, I am receiveing a stream which I have made as a controller and initialized it in the main and finding it here so that I wouldnt be fetching it all the time to reduce cost.
                //the stream is stored in a rxlist when fetching the data and I use the list everywhere
                //so here what I am doing is,I am targeting each list and fetching the data that is a map from them.
                scrollDirection: Axis.horizontal,
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  final data = lists[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () async{
                        if (data['id'] != null) {
                         await viewController.markItemAsViewedByUser(data['id'],);//this must come first to prevent no document to update
                         await viewController.markItemAsViewed(data['id'], data['ownerId']);
                         await Get.toNamed("/shopitems/itemcode/${data['id']}");
                        } else {
                          //I will handle the case when 'id' is null
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
                  //  Text("${data["price"]}");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
