import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/forms_repo/search_screen.dart';
import 'package:campus_sell/forms_repo/sell_page.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/main_board/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Trial extends StatelessWidget {
  Trial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widtht_of_screen =
        MediaQuery.of(context).size.width; // returns width of the screen
    double height_of_screen =
        MediaQuery.of(context).size.height; // returns width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          endDrawer: Drawer(
          child: ListView(
            children: [
               ListTile(
                leading:const Icon(Icons.person),
                title: const Text('Additional Info'),
                onTap: () => Get.to(()=>const SellInfoScreen()),
              ),
               ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search Item'),
                onTap: () => Get.to(()=>SearchScreen()),
              ),
               ListTile(
                leading: const Icon(Icons.sell),
                title:  const Text('Sell Item'),
                onTap: () => Get.to(()=>SellPage()),
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
                      EdgeInsets.only(left: 2, top: 30, right: 2, bottom: 10),
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
                child: FutureBuilderForRowItemsOnDashboard( widtht_of_screen,),
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
      ),
    );
  }

  FutureBuilder<QuerySnapshot<Map<String, dynamic>>> FutureBuilderForRowItemsOnDashboard(double screenWidth,) {
    return FutureBuilder(
          future: FirebaseFirestore.instance.collection("items").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<DocumentSnapshot<Map<String, dynamic>>> items = snapshot.data!.docs;
        List<DocumentSnapshot<Map<String, dynamic>>> filteredItems = items.where((item) => item.data()!['itemType'] == "items").toList();
              return SizedBox(
                height: 200,
                width: screenWidth,//size of the horizontal display for groups of items
                
                  child: GridView.builder( // used gridview because listview was giving me problem on horizontal axis
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1, // Set the spacing between items
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(// container for color purpose and to help design
                          color: Colors.blueAccent,
                          
                          child: ListTile(
                            selectedColor: Colors.black26,
                            title: Text(filteredItems[index].data()!['itemType'].toString()),
                            trailing: Text("last"),
                          ),
                        ),
                        onTap: () => print('${index.toString()}'),
                      );
                    },
                  ),
              
              );
            } else {
              return Center(child: Text('Error Loading Data'));
            }
          },
        );
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(Trial());
}

Visibility TitleSingleScrollView() {
      const  bool  statusIsVisible = true;

    return const Visibility(
      visible: statusIsVisible,
      child:  SingleChildScrollView(
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
  
  