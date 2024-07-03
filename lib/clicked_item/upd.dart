// import 'package:campus_sell/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Update Firestore Collection'),
//         ),
//         body: UpdateCollection(),
//       ),
//     );
//   }
// }

// class UpdateCollection extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> updateCollection() async {
//     CollectionReference collectionRef = _firestore.collection('items');
    
//     QuerySnapshot querySnapshot = await collectionRef.get();

//     for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//       await doc.reference.update({'likes': []});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () async {
//           await updateCollection();
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Collection Updated')),
//           );
//         },
//         child: Text('Update Collection'),
//       ),
//     );
//   }
// }
