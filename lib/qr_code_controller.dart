import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

class QRCodeController extends GetxController {
  // Method to generate and download the QR code
  Future<void> generateAndDownloadQRCode(String data, String fileName, BuildContext context) async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );

      if (qrValidationResult.status == QrValidationStatus.valid) {
        final qrCode = qrValidationResult.qrCode!;
        final painter = QrPainter.withQr(
          qr: qrCode,
          
          gapless: true,
        );

        if (kIsWeb) {
          // Web-specific logic to download the QR code as a PNG
          final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
          final buffer = picData!.buffer.asUint8List();
          final blob = html.Blob([buffer]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute('download', '$fileName.png')
            ..click();
          html.Url.revokeObjectUrl(url);
        } else {
          // Mobile/Desktop logic
          if (await Permission.storage.request().isGranted) {
            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
            if (selectedDirectory != null) {
              final filePath = '$selectedDirectory/$fileName.png';
              final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
              final buffer = picData!.buffer.asUint8List();
              final file = File(filePath);
              await file.writeAsBytes(buffer);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("QR Code downloaded to $filePath")),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Storage permission denied")),
            );
          }
        }
      } else {
        throw Exception("QR Code generation failed");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to download QR code: $e")),
      );
    }
  }
}
