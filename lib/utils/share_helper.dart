import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

class ShareHelper {
  static Future<void> shareScreenshot(GlobalKey key) async {
    final controller = ScreenshotController();
    final image = await controller.captureFromWidget(
      RepaintBoundary(key: key, child: key.currentWidget as Widget),
      delay: const Duration(milliseconds: 100),
    );
    final directory = await getTemporaryDirectory();
    final imagePath = await File('${directory.path}/screenshot.png').create();
    await imagePath.writeAsBytes(image);
    await Share.shareXFiles([
      XFile(imagePath.path),
    ], text: 'Mega Count screenshot');
  }

  static Future<void> shareScreenshotController(
    ScreenshotController controller,
  ) async {
    final image = await controller.capture();
    if (image == null) return;
    final directory = await getTemporaryDirectory();
    final imagePath = await File('${directory.path}/screenshot.png').create();
    await imagePath.writeAsBytes(image);
    await Share.shareXFiles([
      XFile(imagePath.path),
    ], text: 'Mega Count screenshot');
  }
}
