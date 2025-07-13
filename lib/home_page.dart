import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mega_count/l10n/app_localizations.dart';
import 'package:mega_count/main.dart';
import 'counter_column.dart';
import 'utils/vibration_helper.dart';
import 'utils/share_helper.dart';
import 'package:screenshot/screenshot.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counterZunanji = 0;

  final ScreenshotController _screenshotController = ScreenshotController();

  void _incrementCounter() async {
    await vibrate();
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() async {
    await vibrate();
    setState(() {
      _counter--;
    });
  }

  void _incrementCounterZunanji() async {
    await vibrate();
    setState(() {
      _counterZunanji++;
    });
  }

  void _decrementCounterZunanji() async {
    await vibrate();
    setState(() {
      _counterZunanji--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)?.appTitle ?? widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            tooltip: 'Spremeni temo',
            onPressed: () {
              // Poišči najbližji ancestor MaterialApp in spremeni themeMode
              // Uporabimo InheritedWidget za state management
              MyAppTheme.of(context)?.toggleTheme();
            },
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CounterColumn(
                    label:
                        AppLocalizations.of(context)?.internalCorner ??
                        'notranji kot',
                    value: _counter,
                    onIncrement: _incrementCounter,
                    onDecrement: _decrementCounter,
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: CounterColumn(
                    label:
                        AppLocalizations.of(context)?.externalCorner ??
                        'zunanji kot',
                    value: _counterZunanji,
                    onIncrement: _incrementCounterZunanji,
                    onDecrement: _decrementCounterZunanji,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
          ? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.share),
                  label: Text(AppLocalizations.of(context)?.share ?? 'Deli'),
                  onPressed: () async {
                    await ShareHelper.shareScreenshotController(
                      _screenshotController,
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
