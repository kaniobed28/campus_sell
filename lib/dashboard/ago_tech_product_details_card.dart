import 'package:flutter/material.dart';

class AgoTechProductDetailsCard extends StatelessWidget {
  final String title ;
  final String description ;
  final String price ;
  final String brandName ;
  final String phone ;

  const AgoTechProductDetailsCard({super.key, required this.title, required this.description, required this.price, required this.brandName, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffffffff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.
        vertical(top: Radius.circular(25)),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.person, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Text(
                  brandName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.sell, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.phone, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle "More Details" action here
                },
                child: const Text(
                  'More Details',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}