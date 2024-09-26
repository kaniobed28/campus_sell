import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:campus_sell/reusable_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';


class FollowedShopsScreen extends StatefulWidget {
  FollowedShopsScreen({super.key});

  @override
  State<FollowedShopsScreen> createState() => _FollowedShopsScreenState();
}

class _FollowedShopsScreenState extends State<FollowedShopsScreen> {
  final FollowController followController = Get.put(FollowController());
  final AuthController authController = Get.find<AuthController>();
  final AdditionalInfoController additionalInfoController = Get.find<AdditionalInfoController>();

  @override
  Widget build(BuildContext context) {
    // Get the userId from the authenticated user
    String? userId = Get.parameters["id"];

    return Scaffold(
      endDrawer: DrawerWidget(authController: authController),
      appBar: const CustomAppBar(appBarTitle: "Shops I Follow", height: 75),
      body: FutureBuilder<List<String>>(
        future: followController.getUserFollowedShops(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading followed shops'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('You are not following any shops'));
          } else if (snapshot.hasData) {
            List<String> followedShops = snapshot.data!;

            return ListView.builder(
              itemCount: followedShops.length,
              itemBuilder: (context, index) {
                String shopId = followedShops[index];

                // Use FutureBuilder to fetch the shop name
                return FutureBuilder<Map<String, dynamic>?>(
                  future: additionalInfoController.getDocumentById(shopId),  // Fetch shop details by ID
                  builder: (context, shopSnapshot) {
                    if (shopSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (shopSnapshot.hasError) {
                      return const Center(child: Text('Error loading shop details'));
                    } else if (shopSnapshot.hasData) {
                      var data = shopSnapshot.data;
                      String? shopName = data?['brand'];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/shop/shopitems/$shopId");
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blueGrey[200],
                                  child: Icon(
                                    Icons.store,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    shopName ?? 'Unknown Shop',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.blue),
                                  onPressed: () {
                                    // Replace with actual share content logic
                                    Share.share("Check out $shopName on our platform!");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('No shop info'));
                    }
                  },
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
