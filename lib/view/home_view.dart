import 'package:color_generator/core/strings.dart';
import 'package:color_generator/view_model/color_generator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The home screen of the Color Generator app.
///
/// This widget listens to the [colorGeneratorViewModelProvider]
/// to get the current background color.
/// Tapping anywhere on the screen generates a new random color.
/// It also dynamically adjusts the status bar and text color based on
/// the luminance of the background for optimal contrast.
class HomeView extends ConsumerWidget {
  /// Creates a [HomeView] widget.
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color color = ref.watch(colorGeneratorViewModelProvider);

    final double colorLuminance = color.computeLuminance();

    final bool isDarkBackground = colorLuminance > 0.5;

    final Brightness brightness =
        isDarkBackground ? Brightness.dark : Brightness.light;

    final Color textColor = isDarkBackground ? Colors.black : Colors.white;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness,
      ),
    );

    return GestureDetector(
      onTap:
          () =>
              ref.read(colorGeneratorViewModelProvider.notifier).refreshColor(),
      child: Scaffold(
        backgroundColor: color,
        body: Center(
          child: Text(
            AppStrings.homeText,
            style: TextStyle(fontSize: 24.0, color: textColor),
          ),
        ),
      ),
    );
  }
}
