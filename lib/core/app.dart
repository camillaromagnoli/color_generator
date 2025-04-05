import 'package:color_generator/core/app_strings.dart';
import 'package:color_generator/view/home_view.dart';
import 'package:flutter/material.dart';

/// The root widget of the Flutter application.
class App extends StatelessWidget {
  /// Create the app.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppStrings.appName,
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
