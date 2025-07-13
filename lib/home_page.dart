import 'package:flutter/material.dart';
import 'package:mega_count/l10n/app_localizations.dart';
import 'counter_column.dart';
import 'utils/vibration_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counterZunanji = 0;

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
      ),
      body: Center(
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
    );
  }
}
