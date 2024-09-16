import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected; // New property to indicate if the item is selected

  NavBarItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false, // Default is false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : const Color.fromARGB(255, 105, 103, 103), // Highlight if selected
              ),
            ),
            const SizedBox(height: 1.0),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black :const Color.fromARGB(255, 105, 103, 103),  // Highlight if selected
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Bold if selected
              ),
            ),
          ],
        ),
      ),
    );
  }
}
