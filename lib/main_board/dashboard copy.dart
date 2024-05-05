// import 'package:campus_sell/firebase_options.dart';
// import 'package:campus_sell/forms_repo/search_screen.dart';
// import 'package:campus_sell/forms_repo/sell_page.dart';
// import 'package:campus_sell/main_board/clicked_item.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:campus_sell/forms_repo/seller_info_screen.dart';
// import 'package:get/get.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   @override
//   Widget build(BuildContext context) {
//     double widtht_of_screen =
//         MediaQuery.of(context).size.width; // returns width of the screen
//     double height_of_screen =
//         MediaQuery.of(context).size.height; // returns width of the screen
//     return SafeArea(
//       child: Scaffold(
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//                ListTile(
//                 leading:const Icon(Icons.person),
//                 title: const Text('Additional Info'),
//                 onTap: () => Get.to(()=>const SellInfoScreen()),
//               ),
//                ListTile(
//                 leading: const Icon(Icons.search),
//                 title: const Text('Search Item'),
//                 onTap: () => Get.to(()=>SearchScreen()),
//               ),
//                ListTile(
//                 leading: const Icon(Icons.sell),
//                 title:  const Text('Sell Item'),
//                 onTap: () => Get.to(()=>SellPage()),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//           width: widtht_of_screen,
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 // foregroundColor: Colors.amber,
//                 expandedHeight: 200,
//                 floating: true,
//                 // pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   titlePadding:
//                       EdgeInsets.only(left: 2, top: 30, right: 2, bottom: 10),
//                   centerTitle: false,
//                   title: TitleSingleScrollView(),
//                   background: Container(
//                     decoration: const BoxDecoration(
//                         // color: Colors.amber,
//                         borderRadius: BorderRadius.all(Radius.circular(0))),
//                     margin: EdgeInsets.all(0),
//                     child: const Image(
//                         image: AssetImage(
//                             "assets/img/campus-sell-logo-transparent.png")),
//                   ),
//                 ),
//               ),
//               SliverToBoxForTrial(widtht_of_screen, height_of_screen),
//               // FutureBuilderForRowItemsOnDashboard(widtht_of_screen),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 5,
//                   color: Colors.white,
//                 ),
//               ),
//               // SliverToBoxForTrial(widtht_of_screen, height_of_screen),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 5,
//                   color: Colors.white,
//                 ),
//               ),
//               // SliverToBoxForTrial(widtht_of_screen, height_of_screen),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 5,
//                   color: Colors.white,
//                 ),
//               ),
//               // SliverToBoxForTrial(widtht_of_screen, height_of_screen),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 5,
//                   color: Colors.white,
//                 ),
//               ),
//               // SliverToBoxForTrial(widtht_of_screen, height_of_screen),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 5,
//                   color: Colors.white,
//                 ),
//               ),
//               // SliverToBoxForTrial(widtht_of_screen, height_of_screen),
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: 5,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   SliverToBoxAdapter SliverToBoxForTrial(
//       double widtht_of_screen, double height_of_screen,
//       {BuildContext}) {
//     return SliverToBoxAdapter(
//       child: Container(
//         // margin: EdgeInsets.symmetric(horizontal: 0.5),
//         width: widtht_of_screen,
//         height: height_of_screen * 0.3,
//         color: Colors.white,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             /*  I am wraping just only one container for design purpose. I should remember to make it fit for all.
//                  When I click on a box container it should pass a data to the next screen which I can use to query the database
//                 for filling that screen.
//                  Example if I click on a container of a seller product, it should send the ID of the  item to another page and show all information about it.*/
//             GestureDetector(
//               onTap: () {
//                 Get.to(() => ItemDetailsWidget());

//                 // Navigate to a new screen here.
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => ItemDetailsWidget()),
//                 // );
//               },
//               child: Container(
//                 margin: EdgeInsets.all(10),
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.brown,
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               // color: Colors.brown,
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.brown,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// /* The Title Single ScrollView should go to the down part of the dashbord and should allow the user to scroll  through all the posts of 
// goods by seller and each seller has the room to post one thing for 24 hours. */
//   Visibility TitleSingleScrollView() {
//       const  bool  statusIsVisible = true;

//     return const Visibility(
//       visible: statusIsVisible,
//       child:  SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// FutureBuilder<QuerySnapshot<Map<String, dynamic>>> FutureBuilderForRowItemsOnDashboard(double screenWidth,) {
//     return FutureBuilder(
//           future: FirebaseFirestore.instance.collection("users").get(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasData) {
//               return SizedBox(
//                 height: 200,
//                 width: screenWidth,//size of the horizontal display for groups of items
                
//                   child: GridView.builder( // used gridview because listview was giving me problem on horizontal axis
//                     scrollDirection: Axis.horizontal,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 1,
//                       crossAxisSpacing: 1,
//                       mainAxisSpacing: 1, // Set the spacing between items
//                     ),
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         child: Container(// container for color purpose and to help design
//                           color: Colors.blueAccent,
                          
//                           child: ListTile(
//                             selectedColor: Colors.black26,
//                             title: Text(snapshot.data!.docs[index].data()['name'] ?? "no name"),
//                             trailing: Text("last"),
//                           ),
//                         ),
//                         onTap: () => print('${index.toString()}'),
//                       );
//                     },
//                   ),
              
//               );
//             } else {
//               return Center(child: Text('Error Loading Data'));
//             }
//           },
//         );
//   }
//   void main(List<String> args) {
// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(DashBoard());
// }
// }