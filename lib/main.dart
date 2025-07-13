import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mega_count/l10n/app_localizations.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyAppTheme(child: const MyApp()));
}

class MyAppTheme extends StatefulWidget {
  final Widget child;
  const MyAppTheme({super.key, required this.child});

  static _MyAppThemeState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppThemeState>();
  }

  @override
  State<MyAppTheme> createState() => _MyAppThemeState();
}

class _MyAppThemeState extends State<MyAppTheme> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        // Če je system, preklopi na dark
        _themeMode = ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeMode(
      themeMode: _themeMode,
      child: Builder(builder: (context) => MyApp(themeMode: _themeMode)),
    );
  }
}

class _InheritedThemeMode extends InheritedWidget {
  final ThemeMode themeMode;
  const _InheritedThemeMode({required this.themeMode, required Widget child})
    : super(child: child);

  static _InheritedThemeMode? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedThemeMode>();
  }

  @override
  bool updateShouldNotify(_InheritedThemeMode oldWidget) =>
      themeMode != oldWidget.themeMode;
}

class MyApp extends StatelessWidget {
  final ThemeMode? themeMode;
  const MyApp({super.key, this.themeMode});

  @override
  Widget build(BuildContext context) {
    final themeModeValue =
        themeMode ??
        _InheritedThemeMode.of(context)?.themeMode ??
        ThemeMode.system;
    return MaterialApp(
      title: 'Ata Ule šteje kote',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeModeValue,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('sl')],
      home: const MyHomePage(title: ''),
    );
  }
}
