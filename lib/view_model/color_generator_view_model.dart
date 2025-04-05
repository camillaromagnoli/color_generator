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
  @override
  Color build() => _generateRandomColor();

  /// Refreshes the state color with a new generated random color.
  void refreshColor() {
    state = _generateRandomColor();
  }

  Color _generateRandomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }
}
