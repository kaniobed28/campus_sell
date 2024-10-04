// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Campus Sell"),
//         ),
//         body: HomeScreen(),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Search Bar
//           SearchBar(),
//           SizedBox(height: 10),
          
//           // Category Section
//           CategorySection(),
//           SizedBox(height: 20),
          
//           // Sale Banner
//           SaleBanner(),
//           SizedBox(height: 20),
          
//           // Fashion Section
//           FashionSection(),
//         ],
//       ),
//     );
//   }
// }

// class SearchBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Search for items...",
//           prefixIcon: Icon(Icons.search),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }
// }

// class CategorySection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           CategoryItem(icon: Icons.checkroom, label: "Clothing"),
//           CategoryItem(icon: Icons.devices, label: "Electronics"),
//           CategoryItem(icon: Icons.book, label: "Books"),
//           CategoryItem(icon: Icons.home, label: "Home & Living"),
//         ],
//       ),
//     );
//   }
// }

// class CategoryItem extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   CategoryItem({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           child: Icon(icon, size: 30),
//         ),
//         SizedBox(height: 5),
//         Text(label),
//       ],
//     );
//   }
// }

// class SaleBanner extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.purple.shade100,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Summer Sale!\nUp to 50% off on selected items",
//             style: TextStyle(fontSize: 16),
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Shop Now"),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
//           )
//         ],
//       ),
//     );
//   }
// }

// class FashionSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Fashion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               TextButton(onPressed: () {}, child: Text("See All")),
//             ],
//           ),
//         ),
//         FashionItem(),
//       ],
//     );
//   }
// }

// class FashionItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network('https://example.com/trendy-tshirt.jpg'), // Replace with actual image link
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text("Trendy T-shirt", style: TextStyle(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }
// }
