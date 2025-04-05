import 'package:color_generator/view_model/color_generator_view_model.dart';
import 'package:flutter/material.dart';

class ColorGeneratorViewModelMock extends ColorGeneratorViewModel {
  final Color overrideColor;

  ColorGeneratorViewModelMock(this.overrideColor);

  @override
  Color build() => overrideColor;
}
