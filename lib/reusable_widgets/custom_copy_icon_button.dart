import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CopyIconButton extends StatelessWidget {
  final String value;
  final String label;

  const CopyIconButton({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy, color: Colors.blueAccent),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: value));
        Get.snackbar("Copied", "$label copied to clipboard");
      },
    );
  }
}