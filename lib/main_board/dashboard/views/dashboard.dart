import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/all_type_screen.dart';
import 'package:campus_sell/main_board/select.dart';
import 'package:campus_sell/search/views/search_screen.dart';
import 'package:campus_sell/forms_repo/sell_page.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/main_board/buy_promotion.dart';
import 'package:campus_sell/main_board/clicked_item.dart';
import 'package:campus_sell/main_board/delete_page.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardM extends StatelessWidget {
  DashBoardM({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
  var typeCategory = const AllTypeHome();

  @override
  Widget build(BuildContext context) {
    const FontWeight fontWeight = FontWeight.bold;
    const double itemTypeFontSize = 25.0;
    TextStyle fontStyeleForItemTypes = GoogleFonts.average(
        fontWeight: fontWeight,
        fontSize: itemTypeFontSize,
        color: Colors.white);
    double widthtOfScreen =
        MediaQuery.of(context).size.width; // returns width of the screen

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 245, 245, 245), // should be changed to theme.
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Container(
                    width: 120.0, // Adjust width as needed
                    height: 120.0, // Adjust height as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amber,
                        width: 2.0, // Adjust border width as needed
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/img/campus-sell-favicon-color.png",
                        width: 100.0, // Adjust width as needed
                        height: 100.0, // Adjust height as needed
                        fit: BoxFit
                            .cover, // Ensures the image fits within the given dimensions
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Additional Info',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => SellInfoScreen()),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(
                  'Search Item',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => SearchScreen()),
              ),
              ListTile(
                leading: const Icon(Icons.sell),
                title: Text(
                  'Sell Item',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => SellPage()),
              ),
              ListTile(
                leading: const Icon(Icons.delete_sweep),
                title: Text(
                  'Remove Item',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => const DeleteScreen()),
              ),
              ListTile(
                leading: const Icon(Icons.tv),
                title: Text(
                  'Promotion',
                  style: GoogleFonts.average(),
                ),
                onTap: () {
                  //
                  Get.to(() => BuyPromotion());
                },
              ),
              ListTile(
                leading: const Icon(Icons.outbond),
                title: Text(
                  'SignOut',
                  style: GoogleFonts.average(),
                ),
                onTap: () {
                  // AuthController authController = Get.find<AuthController>();
                  // AuthController authController = Get.put(AuthController());
                  authController.signOut();
                  // authController.dispose();
                  Get.offAll(() => SignIn());
                },
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: widthtOfScreen,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                // foregroundColor: Colors.amber,
                expandedHeight: 200,
                floating: true,
                // pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(
                      left: 2, top: 30, right: 2, bottom: 10),
                  centerTitle: true,
                  title: TitleSingleScrollView(),
                  expandedTitleScale: 2,
                  background: Container(
                    decoration: const BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    margin: const EdgeInsets.all(0),
                    child: const Image(
                        image: AssetImage(
                            "assets/img/campus-sell-logo-transparent.png")),
                  ),
                ),
              ),
              // FutureBuilderForRowItemsOnDashboard( widtht_of_screen,),
              SelectableTextRow(),

              // for selecting type of item

              // SliverToBoxAdapter(child: typeCategory),
              
            ],
          ),
        ),
      ),
    );
  }

  
// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(DashBoardM());
// }

Visibility TitleSingleScrollView() {
  const bool statusIsVisible = false;

  return Visibility(
    visible: statusIsVisible,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // width: ,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border:
                    Border.all(color: const Color.fromARGB(255, 255, 255, 245)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border:
                    Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border:
                    Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border:
                    Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            // CircleAvatar(
            //   radius: 20,
            //   backgroundColor: Colors.black,
            //   child: CircleAvatar(
            //     radius: 17,
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}
}