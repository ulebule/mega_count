import 'package:vibration/vibration.dart';

Future<void> vibrate() async {
  if (await Vibration.hasVibrator()) {
    Vibration.vibrate(duration: 100);
  }
}
