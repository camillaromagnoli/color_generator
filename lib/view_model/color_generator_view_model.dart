import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_generator_view_model.g.dart';

/// A [StateNotifierProvider] that manages a randomly generated [Color] state.
///
/// This view model provides functionality to generate and refresh a random
/// color.
/// It initializes with a random color and allows consumers to trigger a new one
/// via [refreshColor].
@riverpod
class ColorGeneratorViewModel extends _$ColorGeneratorViewModel {
  /// The maximum value for any ARGB color channel (Alpha, Red, Green or Blue).
  static const int maxColorRange = 256;

  /// The value for the opacity.
  static const int opacity = 255;

  @override
  Color build() => _generateRandomColor();

  /// Refreshes the state color with a new generated random color.
  void refreshColor() {
    state = _generateRandomColor();
  }

  Color _generateRandomColor() {
    return Color.fromARGB(
      opacity,
      Random().nextInt(maxColorRange),
      Random().nextInt(maxColorRange),
      Random().nextInt(maxColorRange),
    );
  }
}
