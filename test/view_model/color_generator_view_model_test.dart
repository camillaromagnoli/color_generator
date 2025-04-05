import 'package:color_generator/view_model/color_generator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorGeneratorViewModel tests...', () {
    test('should initialize with a random color', () {
      final container = ProviderContainer();
      final color = container.read(colorGeneratorViewModelProvider);

      expect(color, isA<Color>());
    });

    test('refreshColor should generate a new color', () {
      final container = ProviderContainer();
      final notifier = container.read(colorGeneratorViewModelProvider.notifier);

      final color1 = container.read(colorGeneratorViewModelProvider);
      notifier.refreshColor();
      final color2 = container.read(colorGeneratorViewModelProvider);

      expect(color1 != color2, true);
    });
  });
}
