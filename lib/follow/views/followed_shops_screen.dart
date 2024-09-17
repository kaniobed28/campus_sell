import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';

class FollowedShopsScreen extends StatelessWidget {
  final FollowController followController = Get.put(FollowController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Get the userId from the authenticated user
    String userId = authController.uid.string;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shops I Follow'),
      ),
      body: FutureBuilder<List<String>>(
        future: followController.getUserFollowedShops(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading followed shops'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('You are not following any shops'));
          } else if (snapshot.hasData) {
            List<String> followedShops = snapshot.data!;

            return ListView.builder(
              itemCount: followedShops.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.store),
                  title: Text(followedShops[index]), // Display the shop ID
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
