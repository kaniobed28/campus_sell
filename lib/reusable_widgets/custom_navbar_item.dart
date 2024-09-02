
import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  NavBarItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  const EdgeInsets.only(left: 8.0,right: 8),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 1.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}