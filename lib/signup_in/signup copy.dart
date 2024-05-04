// import 'package:campus_sell/forms_repo/search_screen.dart';
// import 'package:campus_sell/forms_repo/seller_info_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Signup extends StatefulWidget {
//   Signup({Key? key}) : super(key: key);

//   @override
//   _SignupState createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late TextEditingController passwordOfFormController;
//   late TextEditingController emailOfFormController;

//   @override
//   void initState() {
//     super.initState();
//     passwordOfFormController = TextEditingController();
//     emailOfFormController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     passwordOfFormController.dispose();
//     emailOfFormController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//   double widtht_of_screen = MediaQuery.of(context).size.width;
//   double height_of_screen = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Container(
//             width:widtht_of_screen ,
//             height: height_of_screen,
//             padding: EdgeInsets.all(10),
//             color: Colors.blueGrey[50],
//             child: Column(
//               children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.shopify_rounded,
//                     size: 80,
//                     color: Colors.amber,
//                   ),
//                   onPressed: () {
//                     // Add functionality to the IconButton if needed
//                   },
//                 ),
//                 Text(
//                   "Campus Sell",
//                 ),
//                 const SizedBox(height: 128),
//                 emailFormWidget(emailOfFormController),
//                 const SizedBox(height: 60),
//                 passWrdFormWidget(passwordOfFormController),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Colors.amber),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Add functionality for form submission here
//                         // For example, you can access the form data using:
//                         // emailOfFormController.text and passwordOfFormController.text
//                           Get.to(() => SellInfoScreen());


//                         Navigator.push(
//                           context,MaterialPageRoute(builder: (context) => SellInfoScreen()), );
//                       }
//                     },
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 Text("Already have an account? Sign in",),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Form methods
//   TextFormField passWrdFormWidget(
//       TextEditingController passwordOfFormController) {
//     return TextFormField(
      
//       controller: passwordOfFormController,
//       obscureText: true,
//       decoration: const InputDecoration(
//         prefixIcon:  Icon(Icons.lock_outline),
//         labelText: "Password",
//         border: OutlineInputBorder(),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your password';
//         }
//         return null;
//       },
//     );
//   }

//   TextFormField emailFormWidget(
//       TextEditingController emailOfFormController) {
//     return TextFormField(
//       controller: emailOfFormController,
//       keyboardType: TextInputType.emailAddress,
//       decoration: const InputDecoration(
//         prefixIcon: Icon(Icons.mail),
//         labelText: "E-mail",
//         border: OutlineInputBorder(),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your email';
//         }
//         return null;
//       },
//     );
//   }
// }
