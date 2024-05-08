import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/forms_repo/search_screen.dart';
import 'package:campus_sell/forms_repo/sell_page.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/main_board/clicked_item.dart';
import 'package:campus_sell/signup_in/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardM extends StatelessWidget {
  DashBoardM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widtht_of_screen =
        MediaQuery.of(context).size.width; // returns width of the screen
    double height_of_screen =
        MediaQuery.of(context).size.height; // returns width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    return  SafeArea(
        child: Scaffold(
          endDrawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Additional Info'),
                  onTap: () => Get.to(() => const SellInfoScreen()),
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Search Item'),
                  onTap: () => Get.to(() => const SearchScreen()),
                ),
                ListTile(
                  leading: const Icon(Icons.sell),
                  title: const Text('Sell Item'),
                  onTap: () => Get.to(() => SellPage()),
                ),
                ListTile(
                  leading: const Icon(Icons.tv),
                  title: const Text('Advertisment'),
                  onTap: () {
                      // 

                  },
                ),
                ListTile(
                  leading: const Icon(Icons.outbond),
                  title: const Text('SignOut'),
                  onTap: () {
                      AuthController authController = Get.find<AuthController>();
                      authController.signOut();
                      Get.to(() => SignIn());

                  },
                ),
              ],
            ),
          ),
          body: Container(
            width: widtht_of_screen,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  // foregroundColor: Colors.amber,
                  expandedHeight: 200,
                  floating: true,
                  // pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        const EdgeInsets.only(left: 2, top: 30, right: 2, bottom: 10),
                    centerTitle: false,
                    title: TitleSingleScrollView(),
                    background: Container(
                      child: const Image(
                          image: AssetImage(
                              "assets/img/campus-sell-logo-transparent.png")),
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      margin: EdgeInsets.all(0),
                    ),
                  ),
                ),
                // FutureBuilderForRowItemsOnDashboard( widtht_of_screen,),
                
                SliverToBoxAdapter(
                  child: Row(
                    children: [const Text("Fashion"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "fashion"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [const Text("Food"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "food"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [const Text("Electronic"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "electronic"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [const Text("Beauty Products"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "beauty"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [const Text("Sports Equipmen"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "sports"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [const Text("Stationery"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "stationery"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [ const Text("Healthcare Products"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "healthcare "),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [Text("Kitchen Appliances"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "kitchen"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [Text("Jewelry"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "jewelry"),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [Text("Others"),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilderForRowItemsOnDashboard(
                      widtht_of_screen, "others"),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> StreamBuilderForRowItemsOnDashboard(double screenWidth, String itemType) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("items").snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasData) {
        List<DocumentSnapshot<Map<String, dynamic>>> items =
            snapshot.data!.docs;
        List<DocumentSnapshot<Map<String, dynamic>>> filteredItems = items
            .where((item) => item.data()!['itemType'] == itemType)
            .toList();
        return SizedBox(
          height: 200,
          width:
              screenWidth, //size of the horizontal display for groups of items
          child: GridView.builder(
            // used gridview because listview was giving me problem on horizontal axis
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1, // Set the spacing between items
            ),
            itemCount: filteredItems
                .length, //remember to change always to filtered length
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  color: Colors.amber,
                  child: ListTile(
                    selectedColor: Colors.black26,
                    title: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // Same radius as above
                        child: CachedNetworkImage(
  height: 170, // Adjust the height as needed
  imageUrl: filteredItems[index].data()!['imagesUrls'][0],
  placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while loading
  errorWidget: (context, url, error) => Icon(Icons.error), // Widget to display in case of loading error
),

                      ),
                    ),
                    subtitle: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        border: Border.all(
                            color: Colors.black), // Optional: Add a border
                      ),
                      child: Row(
                        children: [
                          Text(filteredItems[index]
                              .data()!['itemName']
                              .toString().trim()),
                         const Expanded(child: SizedBox()),
                          Text(filteredItems[index]
                              .data()!['price']
                              .toString().trim()),
                        ],
                      ),
                    ),
                    // trailing: Text("last"),
                  ),
                ),
                onTap: () => Get.to(const ClickedItem(),arguments: filteredItems[index].data()),
              );
            },
          ),
        );
      } else {
        return const Center(child: Text('Error Loading Data'));
      }
    },
  );
}

}

// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(DashBoardM());
// }

Visibility  TitleSingleScrollView() {
  const bool statusIsVisible = true;

  return const Visibility(
    visible: statusIsVisible,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15,
            ),
          ),
        ],
      ),
    ),
  );
}
