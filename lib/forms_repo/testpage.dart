import 'package:campus_sell/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Trial extends StatelessWidget {
  Trial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("users").get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return SizedBox(
                  height: 200,
                  width: screenWidth,//size of the horizontal display for groups of items
                  
                    child: GridView.builder( // used gridview because listview was giving me problem on horizontal axis
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1, // Set the spacing between items
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(// container for color purpose and to help design
                            color: Colors.blueAccent,
                            
                            child: ListTile(
                              selectedColor: Colors.black26,
                              title: Text(snapshot.data!.docs[index].data()['name'] ?? "no name"),
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
          ),
        ),
      ),
    );
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(Trial());
}